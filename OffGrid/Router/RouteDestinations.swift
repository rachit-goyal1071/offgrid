enum RouteDestinations: Hashable, Identifiable {
    case mapScreen
    
    var id: Self { self }
}

enum ModalFlow: Hashable, Identifiable {
    case claimHandle
    
    var id: Self { self }
}
