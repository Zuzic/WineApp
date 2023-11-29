import Foundation

public struct WineOutputModel: Codable {
    public let id: String
    public let name: String
    public let desc: [WineDescriptionOutputModel]
    public let type: String
    public let sweetness: String
    public let brand: String
    public let region: String
    public let grape: String
    public let image: URL?
    public let status: String
    public let subname: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case desc
        case type
        case sweetness
        case brand
        case region
        case grape
        case image
        case status
        case subname
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(String.self, forKey: .id)
        self.name = try values.decode(String.self, forKey: .name)
        self.desc = try values.decode([WineDescriptionOutputModel].self, forKey: .desc)
        self.type = try values.decode(String.self, forKey: .type)
        self.sweetness = try values.decode(String.self, forKey: .sweetness)
        self.brand = try values.decode(String.self, forKey: .brand)
        self.region = try values.decode(String.self, forKey: .region)
        self.grape = try values.decode(String.self, forKey: .grape)
        self.image = URL(string: try values.decode(String.self, forKey: .image))
        self.status = try values.decode(String.self, forKey: .status)
        self.subname = try values.decodeIfPresent(String.self, forKey: .subname)
    }
}
