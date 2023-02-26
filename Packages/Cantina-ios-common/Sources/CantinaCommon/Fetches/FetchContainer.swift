import Combine
import Foundation

open class FetchContainer<Model> {
    public typealias ModelComparator = (_ lhs: Model, _ rhs: Model) -> Bool

    private let comparator: ModelComparator
    public private(set) var fetcher: PageFetcher<Model>

    public var items: AnyPublisher<[Model], Never> { fetcher.fetchedItemsPublisher }

    public init(fetcher: PageFetcher<Model>, comparator: @escaping ModelComparator) {
        self.comparator = comparator
        self.fetcher = fetcher
    }

    public func fetchFirst() async throws {
        Logger.fetchContainer.verbose("Fetch first page")
        try await fetchFirstPage()
    }

    private func fetchFirstPage() async throws {
        if await fetcher.fetchedItems.isEmpty {
            try await fetcher.fetchMore()
        }
    }

    private func fetchMore() async throws {
        Logger.fetchContainer.verbose("Fetch next page")
        try await fetcher.fetchMore()
    }

    public func onShowAsync(_ item: Model) async throws {
        guard await fetcher.hasMore else { return }

        let items = await fetcher.fetchedItems
        if let index = items.firstIndex(where: { comparator(item, $0) }) {
            if index > (items.count - fetcher.pageSize) {
               try await fetchMore()
            }
        }
    }

    public func reset() async throws {
        Logger.fetchContainer.verbose("Reset")
        await fetcher.reset()
        try await fetchMore()
    }
}
