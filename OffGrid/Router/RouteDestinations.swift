enum RouteDestinations: Hashable, Identifiable {
    case mapScreen
    case spotDetail(spot: Spot)
    
    var id: Self { self }
}

enum ModalFlow: Hashable, Identifiable {
    case claimHandle
    
    var id: Self { self }
}
