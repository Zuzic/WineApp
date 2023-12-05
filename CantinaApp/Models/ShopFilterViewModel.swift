import CantinaClient
import Foundation

// MARK: - ShopFilterModel

struct ShopFilterModel {
    let countryName: String
    let cities: [CityOutputModel]
}

// MARK: - ShopFilterTag

enum ShopFilterTag: Equatable {
    case city(String)
    case state(String)
    case country(String)

    static func == (lhs: ShopFilterTag, rhs: ShopFilterTag) -> Bool {
        switch (lhs, rhs) {
        case (.city, .city): return true
        case (.state, .state): return true
        case (.country, .country): return true
        default: return false
        }
    }
}

struct ShopFilterTagModel: Identifiable {
    let id: String = UUID().uuidString
    let tag: ShopFilterTag

    var name: String {
        switch tag {
        case .city(let string): return string
        case .state(let string): return string
        case .country(let string): return string
        }
    }
}

// MARK: - ShopFilterViewModelDelegate

protocol ShopFilterViewModelDelegate: AnyObject {
    func didSelect(filter: ShopFilterModel)
    func didReset(filters: [ShopFilterModel])
}

// MARK: - ShopFilterViewModel

// sourcery: builder
protocol ShopFilterViewModelInjection {}

final class ShopFilterViewModel: ObservableObject {
    @Published private(set) var tags: [ShopFilterTagModel] = []
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
        reset(country: country)
        let states = country.states
        guard states.count == 1,
              let state = states.first,
              state.type == .other else { return }
        reset(state: state)
    }

    func select(state: StateOutputModel) {
        guard state.id != self.state?.id else { return }
        reset(state: state)
    }

    func select(city: CityOutputModel) {
        guard city.name != self.city?.name else { return }
        reset(city: city)
    }

    func delete(tag: ShopFilterTagModel) {
        switch tag.tag {
        case .city:
            guard let state else { return }
            reset(state: state)
        case .state:
            guard let country else { return }
            reset(country: country)
        case .country:
            reset()
        }
    }

    func reset() {
        country = nil
        state = nil
        city = nil
        delegate?.didReset(filters: countries.shopFilters())
        prepareTags()
    }
}

// MARK: -

private extension ShopFilterViewModel {
    func prepareTags() {
        tags = []

        guard let country else { return }
        tags.append(.init(tag: .country(country.name)))

        guard let state else { return }
        if state.type != .other {
            tags.append(.init(tag: .state(state.state)))
        }

        guard let city else { return }
        tags.append(.init(tag: .city(city.name)))
    }

    func reset(country: CountryOutputModel) {
        self.country = country
        delegate?.didSelect(filter: .init(countryName: country.name, cities: country.cities))
        state = nil
        city = nil
        prepareTags()
    }

    func reset(state: StateOutputModel) {
        self.state = state
        delegate?.didSelect(filter: .init(countryName: state.country?.name ?? "", cities: state.cities))
        city = nil
        prepareTags()
    }

    func reset(city: CityOutputModel) {
        self.city = city
        delegate?.didSelect(filter: .init(countryName: city.state?.country?.name ?? "", cities: [city]))
        prepareTags()
    }
}
