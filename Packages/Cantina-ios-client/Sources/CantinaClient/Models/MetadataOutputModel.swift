import Foundation

struct MetadataOutputModel: Codable {
    let status: [WineStatusOutputModel]
    
    enum CodingKeys: String, CodingKey {
        case status
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.status = try values.decode([WineStatusOutputModel].self, forKey: .status)
    }
}
