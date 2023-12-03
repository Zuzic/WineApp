import Foundation

struct ShopsResponse: Codable {
    let shops: [ShopOutputModel]

    enum CodingKeys: String, CodingKey {
        case shops
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.shops = try values.decode([ShopOutputModel].self, forKey: .shops)
    }
}
