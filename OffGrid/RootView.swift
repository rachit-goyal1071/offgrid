import SwiftUI

struct RootView: View {
    
    @Environment(Theme.self) private var theme
    @Environment(\.[\.spotRepository]) private var spotRepository
    @State private var app =  AppCoordinator()
    private let factory = DestinationFactory()
    
    init() {
        app.isAuthenticated = SessionStore().isLoggedIn
    }
    
    var body: some View {
        Group {
            if app.isAuthenticated {
                mainTabs
            } else {
                LoginScreen(onSuccess: { app.isAuthenticated = true })
            }
        }
        .tint(theme.accentNeon)
    }
    
    private var mainTabs: some View {
        TabView() {
            MapScreen()
                .tabItem { Label("map", systemImage: "map") }
                .tag(AppCoordinator.Tab.map)
            SavedScreen()
                .tabItem { Label("saved", systemImage: "bookmark") }
                .tag(AppCoordinator.Tab.saved)
            // TODO: TO MAKE THIS POST TAB AS A BOTTOM SHEET INSTEAD OF TAB-BAR VIEW
            PostScreen()
                .tabItem { Label("post", systemImage: "plus.circle") }
                .tag(AppCoordinator.Tab.post)
            ProfileScreen(onLogout: { app.isAuthenticated = false })
                .tabItem { Label("you", systemImage: "person") }
                .tag(AppCoordinator.Tab.profile)
        }
    }
    
    private func tabStack(root: some View, router: Router) -> some View {
        @Bindable var router = router
        return NavigationStack(path: $router.path) {
            root
                .navigationDestination(for: RouteDestinations.self) { destination in
                    factory.makeView(for: destination)
                }
        }
        .sheet(item: $router.sheet) { destination in
            factory.makeView(for: destination)
        }
        .environment(router)
    }
}

//class TabBarSection: Identifiable {
//    var title: String
//    var icon: String
//    var screen: any View
//    
//    init(title: String, icon: String, screen: any View) {
//        self.title = title
//        self.icon = icon
//        self.screen = screen
//    }
//}
//
//var availableSections: [TabBarSection] = [
//    .init(title: "map", icon: "map", screen: MapScreen()),
//    .init(title: "saved", icon: "book.fill", screen: SavedScreen()),
//    .init(title: "post", icon: "plus", screen: PostScreen()),
//    .init(title: "profile", icon: "person.crop.circle", screen: ProfileScreen())
//]

//#Preview {
//    @State var theme: Theme = .init()
//    RootView()
//        .environment(theme)
//        .applyTheme(theme)
//    
//}
