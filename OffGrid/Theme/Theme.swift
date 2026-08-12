import SwiftUI

@MainActor
@Observable
final class Theme {
    private enum Key {
        static let isPreviouslySet = "is_previously_set"
        static let selectedThemeName = "selectedThemeName"
        static let followSystemColorScheme = "followSystemColorScheme"
        static let selectedScheme = "selectedScheme"
    }

    @ObservationIgnored private let defaults = UserDefaults.standard

    var isThemePreviouslySet: Bool {
        didSet { defaults.set(isThemePreviouslySet, forKey: Key.isPreviouslySet) }
    }

    var followSystemColorScheme: Bool {
        didSet { defaults.set(followSystemColorScheme, forKey: Key.followSystemColorScheme) }
    }

    var selectedScheme: ThemeScheme {
        didSet { defaults.set(selectedScheme.rawValue, forKey: Key.selectedScheme) }
    }

    var selectedThemeName: ColorThemeName {
        didSet {
            colorPalette = ColorThemeList(name: selectedThemeName)
            defaults.set(selectedThemeName.rawValue, forKey: Key.selectedThemeName)
        }
    }

    private(set) var colorPalette: ColorTheme

    func applyTheme(themeName: ColorThemeName) {
        selectedThemeName = themeName
        selectedScheme = colorPalette.scheme
    }

    var bgBase: Color { colorPalette.bgBase }
    var bgRaised: Color { colorPalette.bgRaised }
    var bgPressed: Color { colorPalette.bgPressed }
    var textPrimary: Color { colorPalette.textPrimary }
    var textSecondary: Color { colorPalette.textSecondary }
    var textTertiary: Color { colorPalette.textTertiary }
    var accentNeon: Color { colorPalette.accentNeon }
    var accentInk: Color { colorPalette.accentInk }
    var statusPending: Color { colorPalette.statusPending }
    var statusNegative: Color { colorPalette.statusNegative }
    var stroke: Color { colorPalette.stroke }
    var mapBase: Color { colorPalette.mapBase }

    init() {
        let defaults = UserDefaults.standard
        isThemePreviouslySet = defaults.bool(forKey: Key.isPreviouslySet)
        // absent → default true / dark / limeLight
        followSystemColorScheme = defaults.object(forKey: Key.followSystemColorScheme) as? Bool ?? false
        selectedScheme = defaults.string(forKey: Key.selectedScheme)
            .flatMap(ThemeScheme.init(rawValue:)) ?? .dark
        let name = defaults.string(forKey: Key.selectedThemeName)
            .flatMap(ColorThemeName.init(rawValue:)) ?? .limeDark
        selectedThemeName = name
        colorPalette = ColorThemeList(name: name)
    }
}
