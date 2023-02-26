import Foundation

extension String {
    var dateValue: Date {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        dateFormatter.timeZone = TimeZone.current
        let date = dateFormatter.date(from: self)
        return date ?? Date()
    }

    var int64Value: Int64 {
        Int64(self) ?? 0
    }
}
