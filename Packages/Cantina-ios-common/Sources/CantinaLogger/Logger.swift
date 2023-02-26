import Foundation
import SwiftyBeaver
import ZIPFoundation

public protocol Logger {
    var scope: String { get }

    func verbose(_ message: @autoclosure @escaping () -> String, file: String, function: String, line: Int)
    func debug(_ message: @autoclosure @escaping () -> String, file: String, function: String, line: Int)
    func info(_ message: @autoclosure @escaping () -> String, file: String, function: String, line: Int)
    func warning(_ message: @autoclosure @escaping () -> String, file: String, function: String, line: Int)
    func error(_ message: @autoclosure @escaping () -> String, file: String, function: String, line: Int)
}

public extension Logger where Self: RawRepresentable {
    var scope: String { "\(rawValue)".uppercased() }
}

public extension Logger {
    private var needWriteLog: Bool {
        LoggerConfigurator.useEnvironmentVariables == false || ProcessInfo.processInfo.environment["\(scope)_LOGS"] != nil
    }

    private func log(level: SwiftyBeaver.Level, _ message: @escaping () -> String, file: String, function: String, line: Int) {
        guard needWriteLog else { return }

        let log = "[\(scope)][\((file as NSString).lastPathComponent):\(line) -- \(function)]: \(message())"
        LoggerConfigurator.logger.custom(level: level, message: log)
    }

    func verbose(_ message: @autoclosure @escaping () -> String, file: String = #file, function: String = #function, line: Int = #line) {
        log(level: .verbose, message, file: file, function: function, line: line)
    }

    func debug(_ message: @autoclosure @escaping () -> String, file: String = #file, function: String = #function, line: Int = #line) {
        log(level: .debug, message, file: file, function: function, line: line)
    }

    func info(_ message: @autoclosure @escaping () -> String, file: String = #file, function: String = #function, line: Int = #line) {
        log(level: .verbose, message, file: file, function: function, line: line)
    }

    func warning(_ message: @autoclosure @escaping () -> String, file: String = #file, function: String = #function, line: Int = #line) {
        log(level: .warning, message, file: file, function: function, line: line)
    }

    func error(_ message: @autoclosure @escaping () -> String, file: String = #file, function: String = #function, line: Int = #line) {
        log(level: .error, message, file: file, function: function, line: line)
    }
}

// MARK: -

public enum LoggerConfigurator {
    fileprivate static let logger = SwiftyBeaver.self
    fileprivate static var useEnvironmentVariables: Bool = false

    public private(set) static var logFileURL: URL?
    public static let logsFolder: URL = {
        let folder = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return URL(fileURLWithPath: folder).appendingPathComponent("logs")
    }()

    public static func configure(useEnvironmentVariables: Bool = false, writeLogFile: Bool = false) {
        LoggerConfigurator.useEnvironmentVariables = useEnvironmentVariables

        logger.removeAllDestinations()
        logger.addDestination(ConsoleDestination())
        if writeLogFile {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            let date = formatter.string(from: Date())

            let url = logsFolder.appendingPathComponent("\(date).log")
            logFileURL = url

            let destination = FileDestination(logFileURL: url)
            destination.logFileMaxSize = (15 * 1024 * 1024)
            logger.addDestination(destination)
            print("Logs output: \(url.path)")
        }
    }

    public static func clearLogs() throws {
        var isDirectory: ObjCBool = false
        guard FileManager.default.fileExists(atPath: logsFolder.path, isDirectory: &isDirectory), isDirectory.boolValue else {
            return
        }

        let destinations = logger.destinations
        logger.removeAllDestinations()

        defer {
            for destination in destinations {
                logger.addDestination(destination)
            }
        }

        try FileManager.default.removeItem(atPath: logsFolder.path)
    }

    public static func zipLogs() throws -> URL {
        var isDirectory: ObjCBool = false
        guard FileManager.default.fileExists(atPath: logsFolder.path, isDirectory: &isDirectory), isDirectory.boolValue else {
            throw NSError(domain: "LoggerDomain", code: -1, userInfo: nil)
        }

        let resultUrl = logsFolder.appendingPathExtension("zip")
        if FileManager.default.fileExists(atPath: resultUrl.path) {
            try FileManager.default.removeItem(atPath: resultUrl.path)
        }

        flush()
        try FileManager.default.zipItem(at: logsFolder, to: resultUrl)
        return URL(fileURLWithPath: resultUrl.path)
    }

    public static func flush() {
        _ = logger.flush(secondTimeout: 10)
    }
}
