import Combine
import Foundation
import Moya

enum RestApiRouter: TargetType, AccessTokenAuthorizable {
    case appRouter(AppRouter)

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .appRouter(let router):
            return router.task
        }
    }

    var headers: [String: String]? {
        let headers = ["X-Correlation-Id": "123"]
        var routeHeaders: [String: String]?

        switch self {
        case .appRouter(let router): routeHeaders = router.headers
        }

        return headers.merging(routeHeaders ?? [:], uniquingKeysWith: { $0 + $1 })
    }

    var method: Moya.Method {
        switch self {
        case .appRouter(let router):
            return router.method
        }
    }

    var path: String {
        switch self {
        case .appRouter(let router):
            return router.path
        }
    }

    var authorizationType: AuthorizationType? {
        return .custom("")
    }
}
