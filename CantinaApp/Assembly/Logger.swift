import CantinaLogger

enum Logger: String, CantinaLogger.Logger {
    var scope: String { "APP:\(rawValue)".uppercased() }

    case general
    case coordinator
    case viewModel
    case view
}
