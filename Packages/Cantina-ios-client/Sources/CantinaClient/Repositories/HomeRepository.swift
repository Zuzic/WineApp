import Foundation

// sourcery: AutoMockable
public protocol HomeRepository {
    func homeInfo() async throws -> HomeOutputModel
    func refreshHomeInfo() async throws -> HomeOutputModel
}

// sourcery: builder
protocol HomeRepositoryInjection {
    var restClient: RestApiClient { get }
    var storage: Storage { get }
    var initialRepository: InitialRepository { get }
}

final class HomeRepositoryImpl: HomeRepository {
    private let injection: HomeRepositoryInjection

    init(injection: HomeRepositoryInjection) {
        self.injection = injection
    }
    
    func homeInfo() async throws -> HomeOutputModel {
        guard let homeInfo = injection.storage.data?.home else { throw NetworkingError.missingData }
        return homeInfo
    }
    
    func refreshHomeInfo() async throws -> HomeOutputModel {
        try await injection.initialRepository.loadInitialData()
        return try await homeInfo()
    }
}
