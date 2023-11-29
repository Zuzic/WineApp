// sourcery: AutoMockable
public protocol ShopRepository {
    func loadShopAddresses() async throws -> [AddressOutputModel]
}

// sourcery: builder
protocol ShopRepositoryInjection {
    var restClient: RestApiClient { get }
    var storage: Storage { get }
}

final class ShopRepositoryImpl: ShopRepository {
    private let injection: ShopRepositoryInjection

    init(injection: ShopRepositoryInjection) {
        self.injection = injection
    }

    func loadShopAddresses() async throws -> [AddressOutputModel] {
        let result: ShopsResponse = try await injection.restClient.asyncPerform(route: .appRouter(.shop))
        return result.addresses
    }
}
