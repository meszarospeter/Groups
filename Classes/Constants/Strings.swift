// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable identifier_name line_length type_body_length
enum L10n {
  /// Empty group list :(
  static let emptyGroupList = L10n.tr("Localizable", "Empty group list :)")
  /// Error
  static let error = L10n.tr("Localizable", "Error")
  /// Groups
  static let groups = L10n.tr("Localizable", "Groups")
  /// OK
  static let ok = L10n.tr("Localizable", "OK")
  /// Something went wrong. Maybe try again...
  static let somethingStrangeHasHappenedMaybeTryTryingAgain = L10n.tr("Localizable", "Something strange has happened. Maybe try trying again..")
}
// swiftlint:enable identifier_name line_length type_body_length

extension L10n {
  fileprivate static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
