import Foundation

public struct WineDescriptionOutputModel: Codable {
    public let title: String
    public let value: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case value
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try values.decode(String.self, forKey: .title)
        self.value = try values.decode(String.self, forKey: .value)
    }
}
