import Alamofire

enum WeatherRoute: Equatable {
    case forecast(LocationQuery, days: Int)
    case search(String)
    
    nonisolated var path: String {
        switch self {
        case .forecast:
            "/forecast.json"
        case .search:
            "/search.json"
        }
    }
    
    nonisolated var method: HTTPMethod {
        switch self {
        case .forecast:
                .get
        case .search:
                .get
        }
    }
    
    nonisolated var queryParameters: [String: String] {
        switch self {
        case let .forecast(query, days):
            return [
                "q": query.q,
                "days": "\(days)",
                "aqi": "no",
                "alerts": "no"
            ]
        case let .search(query):
            return ["q": query]
        }
    }
}




