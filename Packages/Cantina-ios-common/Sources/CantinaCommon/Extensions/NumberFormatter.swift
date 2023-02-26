import Foundation

public extension NumberFormatter {
    static func priceString(price: Double, currencyCode: String) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currencyCode

        guard let result = formatter.string(from: NSNumber(value: price)) else {
            debugPrint("WARRNING: failed to format currency string")
            return ""
        }

        return result
    }
}
