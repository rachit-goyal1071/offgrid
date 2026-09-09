import Alamofire
import Foundation

struct WeatherRequestAdapter: RequestAdapter {
    
    let apiKey: String
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, any Error>) -> Void) {
        
        let keyParam = ["key" : apiKey]
        let encoder = URLEncodedFormParameterEncoder(destination: .queryString)
        do {
            let modifiedRequest = try encoder.encode(keyParam, into: urlRequest)
            completion(.success(modifiedRequest))
        } catch {
            completion(.failure(error))
        }
    }
    
}
