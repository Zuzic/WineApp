// sourcery: AutoMockable
public protocol WineStatusRepository {
    func statusDescription(at status: String) async throws -> String
}

// sourcery: builder
protocol WineStatusRepositoryInjection {
    var storage: Storage { get }
}

final class WineStatusRepositoryImpl: WineStatusRepository {
    private let injection: WineStatusRepositoryInjection
    
    init(injection: WineStatusRepositoryInjection) {
        self.injection = injection
    }
    
    func statusDescription(at status: String) async throws -> String {
        return injection.storage.data?.metadata.status.first(where: { $0.status == status })?.desc ?? ""
    }
}
