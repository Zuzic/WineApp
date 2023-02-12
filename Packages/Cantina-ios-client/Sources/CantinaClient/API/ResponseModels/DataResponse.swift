import Foundation

struct DataResponse: Codable {
    public let home: HomeOutputModel
    public let catalog: [WineOutputModel]
    public let contact: ContactOutputModel
    
    enum CodingKeys: String, CodingKey {
        case home
        case catalog
        case contact
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.home = try values.decode(HomeOutputModel.self, forKey: .home)
        self.catalog = try values.decode([WineOutputModel].self, forKey: .catalog)
        self.contact = try values.decode(ContactOutputModel.self, forKey: .contact)
    }
}
