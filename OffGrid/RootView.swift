import SwiftUI

struct RootView: View {
    
    @Environment(Theme.self) private var theme
    @Environment(\.[\.spotRepository]) private var spotRepository
    @State private var app = AppCoordinator()
    private let factory = DestinationFactory()
    @State private var store: AuthStore
    
    init() {
        _store = State(initialValue: container.authStore)
    }
    
    var body: some View {
        Group {
            if store.state == .idle {
                ProgressView()
                    .tint(theme.accentNeon)
            } else {
                mainTabs
                    .task {
                        if store.state == .loggedOut {
                            await store.login()
                        }
                    }
                    .sheet(item: $app.modal) { factory.makeSheet(for: $0) }
                    .environment(app)
            }
        }
        .tint(theme.accentNeon)
        .onAppear() {
            Task {
                await store.listenAuthEvents()
            }
        }
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
            ProfileScreen()
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
        .sheet(item: $router.sheet) {
            factory.makeSheet(for: $0)
        }
        .environment(router)
    }
}
