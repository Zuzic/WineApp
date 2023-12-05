import Foundation

// MARK: - CountryOutputModel

public final class CountryOutputModel {
    let countryCode: String
    public private(set) var states: [StateOutputModel] = []
    public var name: String {
        return Locale.countryName(atCode: countryCode)
    }

    public var nameAndFlag: String {
        return Locale.countryNameAndFlag(atCode: countryCode)
    }

    public var cities: [CityOutputModel] {
        let cities = states.reduce([CityOutputModel]()) { partialResult, state in
            var result = partialResult
            state.cities.forEach { result.append($0) }
            return result
        }
        return cities.sorted(by: { $0.name < $1.name })
    }

    init(shop: ShopOutputModel) {
        self.countryCode = shop.countryCode
        add(shop: shop)
    }

    func add(shop: ShopOutputModel) {
        if let state = states.first(where: { $0.state == shop.state }) {
            state.add(shop: shop)
        } else {
            states.append(StateOutputModel(shop: shop, country: self))
        }
    }
}

// MARK: - StateOutputModel

public enum StateType: Equatable {
    case state(String)
    case other
}

public final class StateOutputModel: Identifiable {
    public let id: String = UUID().uuidString
    public private(set) var type: StateType = .other
    public private(set) var cities: [CityOutputModel] = []
    public private(set) weak var country: CountryOutputModel?
    public var state: String {
        switch type {
        case .state(let string): return string
        case .other: return "other"
        }
    }

    init(shop: ShopOutputModel, country: CountryOutputModel) {
        if let state = shop.state {
            self.type = .state(state)
        }
        self.country = country
        add(shop: shop)
    }

    func add(shop: ShopOutputModel) {
        if let city = cities.first(where: { $0.name == shop.city }) {
            city.add(shop: shop)
        } else {
            cities.append(CityOutputModel(shop: shop, state: self))
        }
    }
}

// MARK: - CityOutputModel

public final class CityOutputModel: Identifiable {
    public let id: String = UUID().uuidString
    public private(set) var name: String
    public private(set) var addresses: [AddressOutputModel] = []
    public private(set) weak var state: StateOutputModel?

    init(shop: ShopOutputModel, state: StateOutputModel) {
        self.state = state
        self.name = shop.city
        add(shop: shop)
    }

    func add(shop: ShopOutputModel) {
        guard addresses.first(where: { $0.clientID == shop.clientID }) == nil else { return }
        addresses.append(AddressOutputModel(shop: shop, city: self))
    }
}

// MARK: - AddressOutputModel

public final class AddressOutputModel {
    public let clientID: String?
    public let companyName: String
    public let companyName2: String?
    public let address: String
    public let zip: String?
    public private(set) weak var city: CityOutputModel?

    init(shop: ShopOutputModel,
         city: CityOutputModel?)
    {
        self.clientID = shop.clientID
        self.companyName = shop.companyName
        self.companyName2 = shop.companyName2
        self.address = shop.address
        self.zip = shop.zip
        self.city = city
    }
}
