import Foundation

// sourcery: AutoMockable
public protocol ContactRepository {
    func contactInfo() async throws -> ContactOutputModel
}

// sourcery: builder
protocol ContactRepositoryInjection {
    var restClient: RestApiClient { get }
}

final class ContactRepositoryImpl: ContactRepository {
    private let injection: ContactRepositoryInjection

    init(injection: ContactRepositoryInjection) {
        self.injection = injection
    }
    
    func contactInfo() async throws -> ContactOutputModel {
        let result: DataResponse = try await injection.restClient.asyncPerform(route: .appRouter(.catalog))
        return result.contact
    }
}
