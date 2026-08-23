import SwiftUI

struct DestinationFactory {
    
    @ViewBuilder
    func makeView(for destination: RouteDestinations) -> some View {
//        switch destination {
//            
//        }
    }
    
    @ViewBuilder
    func makeSheet(for sheets: ModalFlow) -> some View {
        switch sheets {
        case .claimHandle:
            HandleClaimSheet()
        }
    }
}
