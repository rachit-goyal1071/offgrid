import Foundation
import Alamofire

enum WeatherSession {
    
    static func make(config: WeatherConfig) -> Session {
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 15.0
        
        let retryPolicy = RetryPolicy(
            retryLimit: 2,
            exponentialBackoffBase: 2,
            exponentialBackoffScale: 1.0,
            retryableHTTPMethods: [.get, .put, .delete, .head, .options],
            retryableHTTPStatusCodes: [429, 500, 502, 503, 504],
            retryableURLErrorCodes: [.timedOut, .networkConnectionLost, .cannotConnectToHost, .notConnectedToInternet]
        )
        
        let interceptor = Interceptor(
            adapters: [WeatherRequestAdapter(apiKey: config.apiKey)],
            retriers: [retryPolicy]
        )
        
        return Session(
            configuration: configuration,
            interceptor: interceptor
        )
    }
    
}
