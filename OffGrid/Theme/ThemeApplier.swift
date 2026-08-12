import SwiftUI

extension View {
    @MainActor func applyTheme(_ theme: Theme) -> some View {
        modifier(ThemeApplier(theme: theme))
    }
}

@MainActor
struct ThemeApplier: ViewModifier {
    @Environment(\EnvironmentValues.colorScheme) var colorScheme
    
    var theme: Theme
    
    var actualColorScheme: SwiftUI.ColorScheme? {
        if theme.followSystemColorScheme {
            return nil
        }
        return theme.selectedScheme == ThemeScheme.dark ? .dark : .light
    }
    
    func body(content: Content) -> some View {
        content
            .preferredColorScheme(actualColorScheme)
            .onAppear {
                if !theme.isThemePreviouslySet {
                    theme.applyTheme(themeName: colorScheme == .dark ? .limeDark : .limeLight)
                } else {
                    theme.applyTheme(themeName: theme.selectedThemeName)
                }
            }
            .onChange(of: colorScheme) { _, new in
                guard theme.followSystemColorScheme else { return }
                theme.applyTheme(themeName: new == .dark ? .limeDark : .limeLight)
                theme.isThemePreviouslySet = true
            }
    }
}
