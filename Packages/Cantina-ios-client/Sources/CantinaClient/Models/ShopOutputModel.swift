import Foundation

struct ShopOutputModel: Codable {
    let clientID: String?
    let companyName: String
    let companyName2: String?
    let address: String
    let zip: String?
    let city: String
    let state: String?
    let countryCode: String

    enum CodingKeys: String, CodingKey {
        case clientID
        case companyName
        case companyName2
        case address
        case zip
        case city
        case state
        case countryCode
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.clientID = try values.decodeIfPresent(String.self, forKey: .clientID)
        self.companyName = try values.decode(String.self, forKey: .companyName)
        self.companyName2 = try values.decodeIfPresent(String.self, forKey: .companyName2)
        self.address = try values.decode(String.self, forKey: .address)
        self.zip = try values.decodeIfPresent(String.self, forKey: .zip)
        self.city = try values.decode(String.self, forKey: .city)
        self.countryCode = try values.decode(String.self, forKey: .countryCode)
        self.state = try values.decodeIfPresent(String.self, forKey: .state)
    }
}
