// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {
  public enum Catalog {
    public enum Item {
      /// Status: %@
      public static func status(_ p1: Any) -> String {
        return L10n.tr("Localizable", "catalog.item.status", String(describing: p1), fallback: "Status: %@")
      }
    }
  }
  public enum Contacts {
    /// Follow us
    public static let followUs = L10n.tr("Localizable", "contacts.follow_us", fallback: "Follow us")
  }
  public enum Tab {
    /// Catalog
    public static let catalog = L10n.tr("Localizable", "tab.catalog", fallback: "Catalog")
    /// Contacts
    public static let contacts = L10n.tr("Localizable", "tab.contacts", fallback: "Contacts")
    /// Home
    public static let home = L10n.tr("Localizable", "tab.home", fallback: "Home")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
