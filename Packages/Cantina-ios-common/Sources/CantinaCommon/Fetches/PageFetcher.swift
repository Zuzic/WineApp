import Combine
import Foundation

public actor PageFetcher<Model> {
    public typealias FetchClosure = (_ page: Int, _ pageSize: Int) async throws -> [Model]

    private var page: Int = 1
    public nonisolated let pageSize: Int

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

    public static func empty<Model>() -> PageFetcher<Model> { PageFetcher<Model>(pageSize: 0, fetchClosure: { _, _ in [] }) }

    public init(pageSize: Int, fetchClosure: @escaping FetchClosure) {
        self.pageSize = pageSize
        self.fetchClosure = fetchClosure
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
                let result = try await fetchClosure(page, pageSize)
                if page == 1 {
                    fetchedItems = result
                } else {
                    fetchedItems.append(contentsOf: result)
                }

                hasMore = !result.isEmpty && result.count == pageSize
                page += hasMore ? 1 : 0
                _fetchInProgress.send(false)
                return result
            }
            return try await fetchMoreTask?.value ?? []
        }
    }

    public func reset() async {
        Logger.pageFetcher.verbose("Fetch reset")

        if let loadMoreTask = fetchMoreTask {
            _ = try? await loadMoreTask.value
        }

        page = 1
        hasMore = true
    }
}
