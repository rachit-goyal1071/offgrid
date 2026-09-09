import SwiftUI
import WeatherUI

struct DestinationFactory {
    
    @ViewBuilder
    func makeView(for destination: RouteDestinations) -> some View {
        switch destination {
        case .mapScreen:
            MapScreen()
        case .spotDetail(let spot):
            SpotDetailScreen(spot: spot)
        case .weatherScreen(let locationQuery, let cityName):
            WeatherDetailView(query: locationQuery, cityName: cityName, repository: container.weatherRepository)
        }
    }
    
    @ViewBuilder
    func makeSheet(for sheets: ModalFlow) -> some View {
        switch sheets {
        case .claimHandle:
            HandleClaimSheet()
        }
    }
}
