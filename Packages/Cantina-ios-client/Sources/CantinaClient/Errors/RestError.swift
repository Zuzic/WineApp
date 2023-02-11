import Foundation

enum RestError: Error {
    case stubLoadingError
    case disconnectError
    case mappingObjectError
    case invalidToken
    case unknown
}
