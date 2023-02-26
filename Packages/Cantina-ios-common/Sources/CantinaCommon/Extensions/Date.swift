import Foundation

public extension Date {
    var timeAgoString: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }

    var mediumDateString: String {
        DateFormatter.localizedString(from: self, dateStyle: .medium, timeStyle: .none)
    }
}
