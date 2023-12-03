import CantinaClient
import Foundation

struct ShopFilterModel {
    let countryName: String
    let cities: [CityOutputModel]
}

protocol ShopFilterViewModelDelegate: AnyObject {
    func didSelect(filter: ShopFilterModel)
    func didReset(filters: [ShopFilterModel])
}

// sourcery: builder
protocol ShopFilterViewModelInjection {}

final class ShopFilterViewModel: ObservableObject {
    @Published private(set) var countries: [CountryOutputModel] = []
    @Published private(set) var country: CountryOutputModel?
    @Published private(set) var state: StateOutputModel?
    @Published private(set) var city: CityOutputModel? {
        didSet {
            guard let city else { return }

            country = city.state?.country
            state = city.state
        }
    }

    private weak var delegate: ShopFilterViewModelDelegate?
    private let injection: ShopFilterViewModelInjection

    init(injection: ShopFilterViewModelInjection,
         delegate: ShopFilterViewModelDelegate? = nil)
    {
        self.injection = injection
        self.delegate = delegate
    }

    func update(countries: [CountryOutputModel]) {
        self.countries = countries
    }

    func select(country: CountryOutputModel) {
        guard country.name != self.country?.name else { return }
        self.country = country
        delegate?.didSelect(filter: .init(countryName: country.name, cities: country.cities))
        state = nil
    }

    func select(state: StateOutputModel) {
        guard state.state != self.state?.state else { return }
        self.state = state
        delegate?.didSelect(filter: .init(countryName: state.country?.name ?? "", cities: state.cities))
        city = nil
    }

    func select(city: CityOutputModel) {
        self.city = city
        delegate?.didSelect(filter: .init(countryName: city.state?.country?.name ?? "", cities: [city]))
    }

    func reset() {
        country = nil
        state = nil
        city = nil
        delegate?.didReset(filters: countries.shopFilters())
    }
}
