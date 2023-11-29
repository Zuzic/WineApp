import Foundation

public struct AddressOutputModel: Codable {
    public let clientID: String
    public let companyName: String
    public let companyName2: String?
    public let address: String
    public let zip: String?
    public let city: String
    public let state: String
    public let countryCode: String

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

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.clientID = try values.decode(String.self, forKey: .clientID)
        self.companyName = try values.decode(String.self, forKey: .companyName)
        self.companyName2 = try values.decodeIfPresent(String.self, forKey: .companyName2)
        self.address = try values.decode(String.self, forKey: .address)
        self.zip = try values.decodeIfPresent(String.self, forKey: .zip)
        self.city = try values.decode(String.self, forKey: .city)
        self.state = try values.decode(String.self, forKey: .state)
        self.countryCode = try values.decode(String.self, forKey: .countryCode)
    }
}
