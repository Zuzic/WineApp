import Foundation

extension NSError {
    class func serverError(url _: URL?, statusCode: Int) -> NSError {
        return self.init(domain: "CoreServerErrorDomain", code: statusCode, userInfo: nil)
    }
}
