import Foundation
import Moya

enum AppRouter {
    case catalog
    case shop
}

extension AppRouter: TargetType {
    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .catalog, .shop:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }

    var method: Moya.Method {
        return .get
    }

    var path: String {
        switch self {
        case .catalog: return "/data.json"
        case .shop: return "/shop.json"
        }
    }
}
