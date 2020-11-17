// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSFont
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIFont
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "FontConvertible.Font", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias Font = FontConvertible.Font

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length
// swiftlint:disable implicit_return

// MARK: - Fonts

// swiftlint:disable identifier_name line_length type_body_length
internal enum FontFamily {
  internal enum OpenSans {
    internal static let bold = FontConvertible(name: "OpenSans-Bold", family: "Open Sans", path: "OpenSans-Bold.ttf")
    internal static let boldItalic = FontConvertible(name: "OpenSans-BoldItalic", family: "Open Sans", path: "OpenSans-BoldItalic.ttf")
    internal static let extraBold = FontConvertible(name: "OpenSans-ExtraBold", family: "Open Sans", path: "OpenSans-ExtraBold.ttf")
    internal static let extraBoldItalic = FontConvertible(name: "OpenSans-ExtraBoldItalic", family: "Open Sans", path: "OpenSans-ExtraBoldItalic.ttf")
    internal static let italic = FontConvertible(name: "OpenSans-Italic", family: "Open Sans", path: "OpenSans-Italic.ttf")
    internal static let light = FontConvertible(name: "OpenSans-Light", family: "Open Sans", path: "OpenSans-Light.ttf")
    internal static let lightItalic = FontConvertible(name: "OpenSans-LightItalic", family: "Open Sans", path: "OpenSans-LightItalic.ttf")
    internal static let regular = FontConvertible(name: "OpenSans-Regular", family: "Open Sans", path: "OpenSans-Regular.ttf")
    internal static let semiBold = FontConvertible(name: "OpenSans-SemiBold", family: "Open Sans", path: "OpenSans-SemiBold.ttf")
    internal static let semiBoldItalic = FontConvertible(name: "OpenSans-SemiBoldItalic", family: "Open Sans", path: "OpenSans-SemiBoldItalic.ttf")
    internal static let all: [FontConvertible] = [bold, boldItalic, extraBold, extraBoldItalic, italic, light, lightItalic, regular, semiBold, semiBoldItalic]
  }
  internal static let allCustomFonts: [FontConvertible] = [OpenSans.all].flatMap { $0 }
  internal static func registerAllCustomFonts() {
    allCustomFonts.forEach { $0.register() }
  }
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

internal struct FontConvertible {
  internal let name: String
  internal let family: String
  internal let path: String

  #if os(OSX)
  internal typealias Font = NSFont
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Font = UIFont
  #endif

  internal func font(size: CGFloat) -> Font! {
    return Font(font: self, size: size)
  }

  internal func register() {
    // swiftlint:disable:next conditional_returns_on_newline
    guard let url = url else { return }
    CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
  }

  fileprivate var url: URL? {
    return BundleToken.bundle.url(forResource: path, withExtension: nil)
  }
}

internal extension FontConvertible.Font {
  convenience init?(font: FontConvertible, size: CGFloat) {
    #if os(iOS) || os(tvOS) || os(watchOS)
    if !UIFont.fontNames(forFamilyName: font.family).contains(font.name) {
      font.register()
    }
    #elseif os(OSX)
    if let url = font.url, CTFontManagerGetScopeForURL(url as CFURL) == .none {
      font.register()
    }
    #endif

    self.init(name: font.name, size: size)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    Bundle(for: BundleToken.self)
  }()
}
// swiftlint:enable convenience_type
