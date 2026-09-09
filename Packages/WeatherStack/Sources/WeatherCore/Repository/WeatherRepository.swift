public protocol WeatherRepository: Sendable {
    
    func forecast(for query: LocationQuery, days: Int) async throws -> Weather
    func search(_ text: String) async throws -> [CityMatch]
}

public extension WeatherRepository {
    
    func forecast(for query: LocationQuery) async throws -> Weather {
        try await forecast(for: query, days: 3)
    }
}
