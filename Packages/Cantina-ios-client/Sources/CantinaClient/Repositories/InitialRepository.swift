import Foundation

// sourcery: AutoMockable
public protocol InitialRepository {
    func loadInitialData() async throws
}

// sourcery: builder
protocol InitialRepositoryInjection {
    var restClient: RestApiClient { get }
    var storage: Storage { get }
}

final class InitialRepositoryImpl: InitialRepository {
    private let injection: InitialRepositoryInjection
    
    init(injection: InitialRepositoryInjection) {
        self.injection = injection
    }
    
    func loadInitialData() async throws {
        let result: DataResponse = try await injection.restClient.asyncPerform(route: .appRouter(.catalog))
        self.injection.storage.update(data: result)
    }
}
