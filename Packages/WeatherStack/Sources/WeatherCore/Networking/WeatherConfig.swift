import Foundation

public struct WeatherConfig: Sendable {
    
    public init(baseURL: URL, apiKey: String) {
        self.baseURL = baseURL
        self.apiKey = apiKey
    }
    
    let baseURL: URL
    let apiKey: String
}
