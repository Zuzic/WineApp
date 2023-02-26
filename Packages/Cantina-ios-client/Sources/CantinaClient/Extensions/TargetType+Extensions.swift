import Foundation
import Moya

// MARK: - TargetType

extension TargetType {
    var baseURL: URL {
        fatalError("TargetType baseURL")
    }
}

extension AccessTokenAuthorizable {
    var authorizationType: AuthorizationType? {
        return .custom("")
    }
}
