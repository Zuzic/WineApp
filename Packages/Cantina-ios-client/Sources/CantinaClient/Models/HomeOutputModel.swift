import Foundation

public struct HomeOutputModel: Codable {
    public let title: String
    public let desc: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case desc
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try values.decode(String.self, forKey: .title)
        self.desc = try values.decode(String.self, forKey: .desc)
    }
}
