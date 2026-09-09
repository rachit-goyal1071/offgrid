import Foundation
import Alamofire

struct WeatherRequestFactory: Sendable {
    
    let config: WeatherConfig
    
    nonisolated func makeRequest(route: WeatherRoute) throws -> URLRequest {
        let url = config.baseURL.appendingPathComponent(route.path)
        let method = route.method
        let encoder = URLEncodedFormParameterEncoder(destination: .queryString)
        let urlRequest = try URLRequest(url: url, method: method)
        
        return try encoder.encode(route.queryParameters, into: urlRequest)
    }
}
