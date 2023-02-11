import StreamsLogger

enum Logger: String, StreamsLogger.Logger {
    var scope: String { "APP:\(rawValue)".uppercased() }

    case general
    case coordinator
    case viewModel
    case view
}
