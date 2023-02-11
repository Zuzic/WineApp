import Foundation

public enum ValidationError: Error {
    case unknown
    case incorrectEmail
    case incorrectName
    case incorrectPassword
    case incorrectPhone
    case incorrectUsername
    case incorrectSMSCode
    case incorrectFirstname
    case incorrectLastname
}

extension ValidationError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unknown:
            return "unknown"
        case .incorrectFirstname:
            return "Invalid firstName"
        case .incorrectLastname:
            return "Invalid lastName"
        case .incorrectEmail:
            return "Invalid email"
        case .incorrectName:
            return "Invalid name"
        case .incorrectPassword:
            return "Invalid password"
        case .incorrectPhone:
            return "Invalid phone"
        case .incorrectUsername:
            return "Invalid username"
        case .incorrectSMSCode:
            return "Invalid SMS code"
        }
    }
}
