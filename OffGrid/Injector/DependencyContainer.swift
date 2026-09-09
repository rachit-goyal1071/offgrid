import Foundation
import WeatherCore

@MainActor
final class DependencyContainer {
    
    static let shared = DependencyContainer()
    private let weatherBaseUrl: URL
    
    private init() {
        guard let url = URL(string: Secrets.baseUrl) else { fatalError("Missing url in plist") }
        self.weatherBaseUrl = url
    }
    
    let supabase = Config.shared.client
    
    // MARK: - MapScreen Section
    var spotRepository: () -> SpotRepository {
        return {
            SpotRepositoryImpl(client: self.supabase)
        }
    }
    
    lazy var mapStore: MapStore = {
        MapStore(repository: self.spotRepository())
    }()
    
    // MARK: - LoginScreen Section
    var authService: () -> AuthRepositoryImpl {
        return {
            AuthRepositoryImpl(client: self.supabase)
        }
    }
    
    lazy var authStore: AuthStore = {
        AuthStore(service: self.authService())
    }()
    
    // MARK: - SavedScreen Section
    var savedRepository: () -> SavedSpotRepository {
        return {
            UserDefaultsSavedSpotRepositoryImpl()
        }
    }
    
    lazy var savedStore: SavedStore = {
        SavedStore(repository: self.savedRepository())
    }()
    
    // MARK: - ProfileScreen Section
    var profileRepository: () -> ProfileRepository {
        return {
            ProfileRepositoryImpl(client: self.supabase)
        }
    }
    
    lazy var profileStore: ProfileStore = {
        ProfileStore(repository: self.profileRepository(), authRepository: self.authService())
    }()
    
    // MARK: - Weather Config
    
    lazy var weatherConfig = WeatherConfig(baseURL: self.weatherBaseUrl, apiKey: Secrets.weatherAPIKey)
    
    // MARK: - Weather Repository
    
    lazy var weatherRepository = WeatherStack.makeRepository(config: weatherConfig)
}

let container = DependencyContainer.shared
