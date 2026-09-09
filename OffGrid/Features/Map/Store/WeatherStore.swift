import SwiftUI
import WeatherCore

@MainActor
@Observable
final class WeatherStore {
    
    private(set) var state: ViewState = .idle
    let repository: WeatherRepository
    
    init(repository: WeatherRepository) {
        self.repository = repository
    }
    
    enum ViewState {
        case idle
        case loading
        case loaded(Weather)
        case failed(String)
    }
}
