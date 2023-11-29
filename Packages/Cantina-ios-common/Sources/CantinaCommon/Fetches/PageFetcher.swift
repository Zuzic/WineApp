import Combine
import Foundation

// MARK: - PageFetcher

public actor PageFetcher<Model> {
    private typealias FetchClosure = (_ type: FetcherType, _ pageSize: Int) async throws -> ([Model], String?)
    public typealias PageFetchClosure = (_ page: Int, _ pageSize: Int) async throws -> [Model]
    public typealias TokenFetchClosure = (_ token: String?, _ pageSize: Int) async throws -> ([Model], String?)
    public typealias ListFetchClosure = () async throws -> [Model]

    public nonisolated let pageSize: Int
    private var type: FetcherType

    private let _fetchedItemsPublisher = CombineState<[Model]>(value: [])
    public nonisolated var fetchedItemsPublisher: AnyPublisher<[Model], Never> { _fetchedItemsPublisher.wrappedValue }
    public private(set) var fetchedItems: [Model] = [] { didSet {
        _fetchedItemsPublisher.send(fetchedItems)
    }}

    private let _hasMorePublisher = CombineState<Bool>(value: true)
    public nonisolated var hasMorePublisher: AnyPublisher<Bool, Never> { _hasMorePublisher.wrappedValue }
    public private(set) var hasMore: Bool = true { didSet {
        _hasMorePublisher.send(hasMore)
    }}

    private let _fetchInProgress = CombineState<Bool>(value: false)
    public nonisolated var fetchInProgress: AnyPublisher<Bool, Never> { _fetchInProgress.wrappedValue }

    private var fetchMoreTask: Task<[Model], Error>?
    private let fetchClosure: FetchClosure

    public static func empty<T>() -> PageFetcher<T> { PageFetcher<T>(pageSize: 0, pageFetchClosure: { _, _ in [] }) }

    public init(pageSize: Int, pageFetchClosure: @escaping PageFetchClosure) {
        self.pageSize = pageSize
        self.fetchClosure = { type, pageSize in
            guard case .page(let value) = type else { return ([], nil) }
            let result = try await pageFetchClosure(value, pageSize)
            return (result, nil)
        }
        self.type = .page(1)
    }

    public init(expectedCount: Int, tokenFetchClosure: @escaping TokenFetchClosure) {
        self.pageSize = expectedCount
        self.fetchClosure = { type, pageSize in
            guard case .token(let value) = type else { return ([], nil) }
            return try await tokenFetchClosure(value, pageSize)
        }
        self.type = .token(nil)
    }

    public init(listFetchClosure: @escaping ListFetchClosure) {
        self.pageSize = 0
        self.fetchClosure = { type, _ in
            guard case .list = type else { return ([], nil) }
            let result = try await listFetchClosure()
            return (result, nil)
        }
        self.type = .list
    }

    @discardableResult
    public func fetchMore() async throws -> [Model] {
        guard hasMore else { return [] }

        Logger.pageFetcher.verbose("Fetch more")

        defer {
            fetchMoreTask = nil
        }

        if let loadMoreTask = fetchMoreTask {
            return try await loadMoreTask.value
        } else {
            fetchMoreTask = Task {
                _fetchInProgress.send(true)
                let result = try await fetchClosure(type, pageSize)
                let items = result.0
                if type.isInitial {
                    fetchedItems = items
                } else if items.count > 0 {
                    fetchedItems.append(contentsOf: items)
                }

                switch type {
                case .page(let page):
                    hasMore = !items.isEmpty && items.count == pageSize
                    type = .page(hasMore ? page + 1 : page)
                case .token:
                    hasMore = !items.isEmpty && result.1 != nil
                    type = .token(result.1)
                case .list: hasMore = false
                }

                _fetchInProgress.send(false)
                return items
            }
            return try await fetchMoreTask?.value ?? []
        }
    }

    public func reset() async {
        Logger.pageFetcher.verbose("Fetch reset")

        if let loadMoreTask = fetchMoreTask {
            _ = try? await loadMoreTask.value
        }

        hasMore = true

        switch type {
        case .page: type = .page(1)
        case .token: type = .token(nil)
        case .list: type = .list
        }
    }
}

// MARK: - FetcherType

private enum FetcherType {
    case page(Int)
    case token(String?)
    case list

    var isInitial: Bool {
        switch self {
        case .page(let page): return page == 1
        case .token(let token): return token == nil
        case .list: return true
        }
    }
}
