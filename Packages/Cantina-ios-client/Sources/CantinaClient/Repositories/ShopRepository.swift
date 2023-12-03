// sourcery: AutoMockable
public protocol ShopRepository {
    func loadShopAddresses() async throws -> [CountryOutputModel]
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

    func loadShopAddresses() async throws -> [CountryOutputModel] {
        let result: ShopsResponse = try await injection.restClient.asyncPerform(route: .appRouter(.shop))
        var countries: [CountryOutputModel] = []
        result.shops.forEach { shop in
            if let country = countries.first(where: { $0.countryCode == shop.countryCode }) {
                country.add(shop: shop)
            } else {
                countries.append(CountryOutputModel(shop: shop))
            }
        }
        return countries
    }
}
