import StreamsLogger

enum Logger: String, StreamsLogger.Logger {
    var scope: String { "Client:\(rawValue)".uppercased() }

    case general
    case rest
}
