import Foundation

// sourcery: AutoMockable
public protocol CatalogRepository {
    func wines() async throws -> [WineOutputModel]
}

// sourcery: builder
protocol CatalogRepositoryInjection {
    var restClient: RestApiClient { get }
}

final class CatalogRepositoryImpl: CatalogRepository {
    private let injection: CatalogRepositoryInjection

    init(injection: CatalogRepositoryInjection) {
        self.injection = injection
    }
    
    func wines() async throws -> [WineOutputModel] {
        let result: DataResponse = try await injection.restClient.asyncPerform(route: .appRouter(.catalog))
        return result.catalog
    }
}
