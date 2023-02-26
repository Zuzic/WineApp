import Foundation

public enum RepositoryError: Error {
    case unknown
    case currentUserNotFound
    case invalidURLString
    case invalidAccountType
    case invalidReaction
    case accountNotExist
}
