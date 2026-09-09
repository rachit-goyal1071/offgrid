import Foundation
import Observation
import WeatherCore

@MainActor
@Observable
public final class WeatherViewModel {
    var weather: Weather?
    var isLoading: Bool = false
    var errorMessage: String?
    
    let repository: WeatherRepository
    
    init(repository: WeatherRepository) {
        self.repository = repository
    }
    
    func loadWeather(for query: LocationQuery) async {
        isLoading = true
        errorMessage = nil
        
        do {
            weather = try await repository.forecast(for: query)
        } catch {
            errorMessage = error.localizedDescription
            weather = nil
        }
        
        isLoading = false
    }
}
