import Foundation

extension Locale {
    static func countryNameAndFlag(atCode: String) -> String {
        let name = Locale.countryName(atCode: atCode)
        guard let isoCode = Locale.countryISOCode(atCode: atCode) else { return name }
        let flag = isoCode
            .unicodeScalars
            .map { 127_397 + $0.value }
            .compactMap(UnicodeScalar.init)
            .map(String.init)
            .joined()

        return "\(flag) \(name)"
    }

    static func countryName(atCode: String) -> String {
        guard let isoCode = Locale.countryISOCode(atCode: atCode),
              let name = Locale(identifier: "en").localizedString(forRegionCode: isoCode.lowercased()) else { return atCode }
        return name
    }

    static func countryISOCode(atCode: String) -> String? {
        debugPrint(NSLocale.isoCountryCodes)
        guard let isoCode = NSLocale.isoCountryCodes.first(where: { $0 == atCode }) else { return nil }
        return isoCode
    }
}
