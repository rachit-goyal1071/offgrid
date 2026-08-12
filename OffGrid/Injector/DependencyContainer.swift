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
    lazy var authService: () -> AuthService = {
        AuthService(client: self.supabase)
    }
    
    lazy var authStore: () -> AuthStore = {
        AuthStore(service: self.authService())
    }
    
    
}

let container = DependencyContainer.shared
