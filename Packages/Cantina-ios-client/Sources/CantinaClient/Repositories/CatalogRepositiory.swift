import Foundation

// sourcery: AutoMockable
public protocol CatalogRepository {
    func wines() async -> [WineOutputModel]
    func updateWines() async throws -> [WineOutputModel]
}

// sourcery: builder
protocol CatalogRepositoryInjection {
    var restClient: RestApiClient { get }
    var storage: Storage { get }
    var initialRepository: InitialRepository { get }
}

final class CatalogRepositoryImpl: CatalogRepository {
    private let injection: CatalogRepositoryInjection

    init(injection: CatalogRepositoryInjection) {
        self.injection = injection
    }
    
    func wines() async -> [WineOutputModel] {
        injection.storage.data?.catalog ?? []
    }
    
    func updateWines() async throws -> [WineOutputModel] {
        try await injection.initialRepository.loadInitialData()
        return await wines()
    }
}
