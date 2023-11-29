import Foundation

struct ShopsResponse: Codable {
    let addresses: [AddressOutputModel]

    enum CodingKeys: String, CodingKey {
        case addresses
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.addresses = try values.decode([AddressOutputModel].self, forKey: .addresses)
    }
}
