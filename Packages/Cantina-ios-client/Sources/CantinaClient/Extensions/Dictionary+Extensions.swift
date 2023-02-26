import Foundation

extension Dictionary {
    func decoding<T: Decodable>(to _: T.Type) -> T? {
        do {
            let json = try JSONSerialization.data(withJSONObject: self)
            let decoder = JSONDecoder()
            let decodedObject = try decoder.decode(T.self, from: json)
            return decodedObject
        } catch {
            return nil
        }
    }
}
