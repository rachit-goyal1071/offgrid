import Foundation

public enum WeatherError: Error {
    case offline
    case notfound
    case unknown(underlying: Error)
}

struct APIErrorResponse: Codable {
    let error: APIError
    
    struct APIError: Codable {
        let code: Int
        let message: String
    }
}
