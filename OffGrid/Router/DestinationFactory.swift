import SwiftUI

struct DestinationFactory {
    
    @ViewBuilder
    func makeView(for destination: RouteDestinations) -> some View {
        switch destination {
        case .mapScreen:
            MapScreen()
        case .spotDetail(let spot):
            SpotDetailScreen(spot: spot)
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
