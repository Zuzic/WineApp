import CantinaLogger

enum Logger: String, CantinaLogger.Logger {
    var scope: String { "CommonCore:\(rawValue)".uppercased() }

    case fetchContainer
    case pageFetcher
}
