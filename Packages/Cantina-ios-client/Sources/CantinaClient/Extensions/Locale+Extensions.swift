import Foundation

extension Locale {
    static func countryCode(from code: String) -> String {
        guard let isoCode = NSLocale.isoCountryCodes.first(where: { $0 == code }),
              let name = Locale(identifier: isoCode).localizedString(forRegionCode: isoCode) else { return code }
        let flag = isoCode
            .unicodeScalars
            .map { 127_397 + $0.value }
            .compactMap(UnicodeScalar.init)
            .map(String.init)
            .joined()

        return "\(flag) \(name)"
    }
}
