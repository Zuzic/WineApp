import Foundation

public struct WineStatusOutputModel: Codable {
    public let status: String
    public let desc: String
    
    enum CodingKeys: String, CodingKey {
        case status
        case desc
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try values.decode(String.self, forKey: .status)
        self.desc = try values.decode(String.self, forKey: .desc)
    }
}
