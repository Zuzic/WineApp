import Foundation

// sourcery: AutoMockable
public protocol HomeRepository {
    func homeInfo() async throws -> HomeOutputModel
}

// sourcery: builder
protocol HomeRepositoryInjection {
    var restClient: RestApiClient { get }
}

final class HomeRepositoryImpl: HomeRepository {
    private let injection: HomeRepositoryInjection

    init(injection: HomeRepositoryInjection) {
        self.injection = injection
    }
    
    func homeInfo() async throws -> HomeOutputModel {
        let result: DataResponse = try await injection.restClient.asyncPerform(route: .appRouter(.catalog))
        return result.home
    }
}
