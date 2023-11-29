import Foundation

// sourcery: AutoMockable
public protocol ContactRepository {
    func contactInfo() async throws -> ContactOutputModel
    func refreshContactInfo() async throws -> ContactOutputModel
}

// sourcery: builder
protocol ContactRepositoryInjection {
    var restClient: RestApiClient { get }
    var storage: Storage { get }
    var initialRepository: InitialRepository { get }
}

final class ContactRepositoryImpl: ContactRepository {
    private let injection: ContactRepositoryInjection

    init(injection: ContactRepositoryInjection) {
        self.injection = injection
    }

    func contactInfo() async throws -> ContactOutputModel {
        guard let contact = injection.storage.data?.contact else { throw NetworkingError.missingData }
        return contact
    }

    func refreshContactInfo() async throws -> ContactOutputModel {
        try await injection.initialRepository.loadInitialData()
        return try await contactInfo()
    }
}
