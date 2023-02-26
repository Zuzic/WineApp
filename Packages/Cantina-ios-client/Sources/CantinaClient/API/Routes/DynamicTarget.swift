import Foundation
import Moya

struct DynamicTarget<T: TargetType & AccessTokenAuthorizable>: TargetType, AccessTokenAuthorizable, CustomStringConvertible {
    let baseURL: URL
    let target: T
    var authorizationType: AuthorizationType? { return target.authorizationType }
    var path: String { return target.path }
    var method: Moya.Method { return target.method }
    var headers: [String: String]? { return target.headers }
    var task: Task { return target.task }
    var sampleData: Data { return target.sampleData }
    var description: String {
        return baseURL.appendingPathComponent(target.path).absoluteString
    }

    init(baseURL: URL, target: T) {
        self.baseURL = baseURL
        self.target = target
    }
}
