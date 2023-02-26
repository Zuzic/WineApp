import Foundation

struct DataResponse: Codable {
    let home: HomeOutputModel
    let catalog: [WineOutputModel]
    let contact: ContactOutputModel
    let metadata: MetadataOutputModel
    
    enum CodingKeys: String, CodingKey {
        case home
        case catalog
        case contact
        case metadata
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.home = try values.decode(HomeOutputModel.self, forKey: .home)
        self.catalog = try values.decode([WineOutputModel].self, forKey: .catalog)
        self.contact = try values.decode(ContactOutputModel.self, forKey: .contact)
        self.metadata = try values.decode(MetadataOutputModel.self, forKey: .metadata)
    }
}
