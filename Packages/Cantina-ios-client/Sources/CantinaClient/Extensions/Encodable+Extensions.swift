import Foundation

extension Encodable {
    var encoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        return encoder
    }

    var dict: [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else { return [:] }
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return [:] }
        return json
    }
}
