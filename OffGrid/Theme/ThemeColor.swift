import SwiftUI

public let availableColorTheme: [ColorThemeName] = [.limeDark, .limeLight]

public protocol ColorTheme: Sendable {
    var name: String { get }
    var scheme: ThemeScheme { get }
    
    /// background
    var bgBase: Color { get }
    var bgRaised: Color { get }
    var bgPressed: Color { get }
    
    /// text
    var textPrimary: Color { get }
    var textSecondary: Color { get }
    var textTertiary: Color { get }
    
    /// accent
    var accentNeon: Color { get }
    var accentInk: Color { get }
    
    /// status
    var statusPending: Color { get }
    var statusNegative: Color { get }
    
    /// miscellaneous
    var stroke: Color { get }
    var mapBase: Color { get }
    
}

public enum ThemeScheme: String, Sendable {
  case dark, light
}

public enum ColorThemeName: String, Sendable {
    case limeDark = "Lime Dark"
    case limeLight = "Lime Light"
}

public func ColorThemeList(name: ColorThemeName) -> ColorTheme {
        switch name {
        case .limeDark:
            return LimeDark()
        case .limeLight:
            return LimeLight()
    }
}

/// Color Definitation

public struct LimeDark: ColorTheme {
    public var name: String = "Lime Dark"
    public var scheme: ThemeScheme = .dark
    public var bgBase: Color = .init(red: 17 / 255, green: 17 / 255, blue: 19 / 255)
    public var bgRaised: Color = .init(red: 26 / 255, green: 26 / 255, blue: 30 / 255)
    public var bgPressed: Color = .init(red: 35 / 255, green: 35 / 255, blue: 40 / 255)
    public var textPrimary: Color = .init(red: 242 / 255, green: 242 / 255, blue: 240 / 255)
    public var textSecondary: Color = .init(red: 168 / 255, green: 168 / 255, blue: 162 / 255)
    public var textTertiary: Color = .init(red: 124 / 255, green: 124 / 255, blue: 120 / 255)
    public var accentNeon: Color = .init(red: 199 / 255, green: 244 / 255, blue: 100 / 255)
    public var accentInk: Color = .init(red: 31 / 255, green: 42 / 255, blue: 5 / 255)
    public var statusPending: Color = .init(red: 245 / 255, green: 196 / 255, blue: 106 / 255)
    public var statusNegative: Color = .init(red: 240 / 255, green: 123 / 255, blue: 107 / 255)
    public var stroke: Color = .init(red: 42 / 255, green: 42 / 255, blue: 47 / 255)
    public var mapBase: Color = .init(red: 19 / 255, green: 19 / 255, blue: 22 / 255)
    
    public init() {}
}

public struct LimeLight: ColorTheme {
    public var name: String = "Lime Light"
    public var scheme: ThemeScheme = .light
    public var bgBase: Color = .init(red: 247 / 255, green: 246 / 255, blue: 241 / 255)
    public var bgRaised: Color = .init(red: 255 / 255, green: 255 / 255, blue: 255 / 255)
    public var bgPressed: Color = .init(red: 236 / 255, green: 235 / 255, blue: 228 / 255)
    public var textPrimary: Color = .init(red: 28 / 255, green: 28 / 255, blue: 24 / 255)
    public var textSecondary: Color = .init(red: 110 / 255, green: 110 / 255, blue: 102 / 255)
    public var textTertiary: Color = .init(red: 156 / 255, green: 156 / 255, blue: 147 / 255)
    public var accentNeon: Color = .init(red: 199 / 255, green: 244 / 255, blue: 100 / 255)
    public var accentInk: Color = .init(red: 95 / 255, green: 125 / 255, blue: 16 / 255)
    public var statusPending: Color = .init(red: 160 / 255, green: 109 / 255, blue: 20 / 255)
    public var statusNegative: Color = .init(red: 194 / 255, green: 80 / 255, blue: 60 / 255)
    public var stroke: Color = .init(red: 229 / 255, green: 228 / 255, blue: 220 / 255)
    public var mapBase: Color = .init(red: 239 / 255, green: 238 / 255, blue: 232 / 255)
    
    public init() {}
}
