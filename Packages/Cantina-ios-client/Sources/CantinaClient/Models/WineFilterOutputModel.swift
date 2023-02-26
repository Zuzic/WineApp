import Foundation

public struct WineFilterOutputModel {
    public let sections: [WineFilterSectionOutputModel]
    
    public init(sections: [WineFilterSectionOutputModel]) {
        self.sections = sections
    }
}

public enum WineFilterSectionOutputModel {
    case type([WineFilterItemOutputModel])
    case brand([WineFilterItemOutputModel])
    case grape([WineFilterItemOutputModel])
}

public struct WineFilterItemOutputModel: Identifiable {
    public let title: String
    public let id: String
    
    init(title: String) {
        self.title = title
        self.id = UUID().uuidString
    }
}
