import Foundation

final class DependencyContainer {
    static let shared = DependencyContainer()
    private init() {}
    
    let supabase = Config.shared.client
    
    // MARK: - MapScreen Section
    lazy var spotRepository: () -> SpotRepository = {
        SpotRepositoryImpl(client: self.supabase)
    }
    
    lazy var mapStore: () -> MapStore = {
        MapStore(repository: self.spotRepository())
    }
    
    // MARK: - LoginScreen Section
    lazy var authService: () -> AuthRepositoryImpl = {
        AuthRepositoryImpl(client: self.supabase)
    }
    
    lazy var authStore: AuthStore = {
        AuthStore(service: self.authService())
    }()
    
    // MARK: SavedScreen Section
    lazy var savedRepository: () -> SavedSpotRepository = {
        UserDefaultsSavedSpotRepositoryImpl()
    }
    
    lazy var savedStore: SavedStore = {
        SavedStore(repository: self.savedRepository())
    }()
    
}

let container = DependencyContainer.shared
