import Foundation

public enum NetworkingError: Error, LocalizedError {
    case unauthorized
    case serverValidationError(String)
    case deviceIsOffline
    case serviceError(Error)
    case resourceNotFound
    case explicitlyCancelled
    case decodingFailed(Error)
    case missingData

    public var errorDescription: String? {
        switch self {
        case .deviceIsOffline:
            return NSLocalizedString("Device is offline. Please check internet connection", comment: "")
        case .unauthorized:
            return NSLocalizedString("User is unauthorized", comment: "")
        case .resourceNotFound:
            return NSLocalizedString("Resource not found", comment: "")
        case .serverValidationError(let message):
            return message
        case .serviceError(let error):
            return error.localizedDescription
        case .explicitlyCancelled:
            return NSLocalizedString("Cancelled", comment: "")
        case .decodingFailed(let error):
            return NSLocalizedString(error.localizedDescription, comment: "")
        case .missingData:
            return "Missing data"
        }
    }
}
