import CantinaLogger

enum Logger: String, CantinaLogger.Logger {
    var scope: String { "Client:\(rawValue)".uppercased() }

    case general
    case rest
}
