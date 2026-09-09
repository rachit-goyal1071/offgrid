import WeatherCore

enum RouteDestinations: Hashable, Identifiable {
    case mapScreen
    case spotDetail(spot: Spot)
    case weatherScreen(locationQuery: LocationQuery, cityName: String)
    
    var id: Self { self }
}

enum ModalFlow: Hashable, Identifiable {
    case claimHandle
    
    var id: Self { self }
}
