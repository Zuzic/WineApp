import Foundation

public enum AuthResponseError: Error {
    case unknown(String)
    case refreshToken
}
