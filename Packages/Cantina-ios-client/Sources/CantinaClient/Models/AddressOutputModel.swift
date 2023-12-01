import Foundation

public final class CountryOutputModel {
    public private(set) var countryCode: String
    public private(set) var states: [StateOutputModel] = []
    
    public var cities: [CityOutputModel] {
        states.reduce([]) { partialResult, state in
            var result = partialResult
            state.cities.forEach { result.append($0) }
            return result
        }
    }
    
    init(shop: ShopOutputModel) {
        self.countryCode = shop.countryCode
        self.add(shop: shop)
    }
    
    func add(shop: ShopOutputModel) {
        if let state = states.first(where: { $0.state == shop.state }) {
            state.add(shop: shop)
        } else {
            states.append(StateOutputModel(shop: shop, country: self))
        }
    }
}

public final class StateOutputModel {
    public private(set) var state: String
    public private(set) var cities: [CityOutputModel] = []
    public private(set) weak var country: CountryOutputModel?
    
    init(shop: ShopOutputModel, country: CountryOutputModel) {
        self.state = shop.state
        self.country = country
        self.add(shop: shop)
    }
    
    func add(shop: ShopOutputModel) {
        if let city = cities.first(where: { $0.name == shop.city }) {
            city.add(shop: shop)
        } else {
            cities.append(CityOutputModel(shop: shop, state: self))
        }
    }
}

public final class CityOutputModel: Identifiable {
    public let id: String = UUID().uuidString
    public private(set) var name: String
    public private(set) var addresses: [AddressOutputModel] = []
    public private(set) weak var state: StateOutputModel?
    
    init(shop: ShopOutputModel, state: StateOutputModel) {
        self.state = state
        self.name = shop.city
        self.add(shop: shop)
    }
    
    func add(shop: ShopOutputModel) {
        guard addresses.first(where: { $0.clientID == shop.clientID }) == nil else { return }
        addresses.append(AddressOutputModel(shop: shop, city: self))
    }
}

public final class AddressOutputModel {
    public let clientID: String
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
