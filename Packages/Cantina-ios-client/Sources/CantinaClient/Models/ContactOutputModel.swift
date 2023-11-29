import Foundation

public struct ContactOutputModel: Codable {
    public let name: String
    public let address: String
    public let phone: String
    public let fax: String
    public let email: String
    public let facebook: String
    public let instagram: String

    enum CodingKeys: String, CodingKey {
        case name
        case address
        case phone
        case fax
        case email
        case facebook
        case instagram
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try values.decode(String.self, forKey: .name)
        self.address = try values.decode(String.self, forKey: .address)
        self.phone = try values.decode(String.self, forKey: .phone)
        self.fax = try values.decode(String.self, forKey: .fax)
        self.email = try values.decode(String.self, forKey: .email)
        self.facebook = try values.decode(String.self, forKey: .facebook)
        self.instagram = try values.decode(String.self, forKey: .instagram)
    }
}
