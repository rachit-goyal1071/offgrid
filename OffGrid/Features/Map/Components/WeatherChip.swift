import SwiftUI
import WeatherCore

struct WeatherChip: View {
    
    @Environment(Theme.self) private var theme
    @Environment(AppCoordinator.self) private var app
    let coordinates: Coordinates
    
    var body: some View {
        Button(action: {
            app.mapRouter.push(.weatherScreen(
                locationQuery: LocationQuery.coordinates(latitude: coordinates.latitude, longitude: coordinates.longitude),
                cityName: "",)
            )
        }){
            Image(systemName: "cloud.fill")
                .foregroundStyle(theme.accentInk)
                .padding(2)
                .background(
                    Capsule()
                        .fill(theme.accentNeon)
                )
                .overlay(
                    Capsule()
                        .stroke(theme.stroke, lineWidth: 1)
                )
        }
    }
}
