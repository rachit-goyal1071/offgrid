import SwiftUI
import WeatherUI

struct WeatherBackdrop: View {
    let palette: WeatherPalette
    
    var body: some View {
        palette.gradient
            .ignoresSafeArea()
            .animation(.easeInOut(duration: 0.7), value: palette.top)
    }
}
