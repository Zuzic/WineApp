import Foundation

struct RestInfo {
    enum ProductionServer {
        static func preparedBaseURL(at endpoint: String) -> URL {
            let path = "https://\(endpoint)"
            Logger.rest.verbose("Rest endpoint: \(path)")
            return URL(string: path)!
        }
    }
}
