enum RouteDestinations: Hashable, Identifiable {
    case mapScreen
    
    var id: Self { self }
}

enum ModalFlow: Hashable, Identifiable {
    case login
    
    var id: Self { self }
}
