import SwiftUI

@Observable
final class AppCoordinator {
    enum Tab { case map, saved, post, profile}
    
    var selectedTab: Tab = .map
    var isAuthenticated: Bool = false
    var modal: ModalFlow?
    
    let mapRouter = Router()
    let savedRouter = Router()
    let profileRouter = Router()
    
    func router(for tab: Tab) -> Router {
        switch tab {
        case .map: return mapRouter
        case .saved: return savedRouter
        case .post: fatalError("No post tab in coordinator")
        case .profile: return profileRouter
        }
    }
    
    func handle(_ url: URL) {
        guard let link = DeepLinkParser.parse(url) else { return }
        switch link {
        case .mapScreen:
            selectedTab = .map
            mapRouter.replacePath([.mapScreen])
        }
    }
}

