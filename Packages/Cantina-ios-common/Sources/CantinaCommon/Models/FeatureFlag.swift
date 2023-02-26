import Foundation

public final class FeatureFlag: Codable {
    public let description: String
    public let enabled: Bool
    public var metadata: [String: String]

    init(description: String, enabled: Bool, metadata: [String: String]) {
        self.description = description
        self.enabled = enabled
        self.metadata = metadata
    }
}
