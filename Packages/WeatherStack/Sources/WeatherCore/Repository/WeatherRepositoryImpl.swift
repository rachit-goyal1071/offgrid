import Alamofire
import Foundation

struct WeatherRepositoryImpl: WeatherRepository {
    
    let session: Session
    let factory: WeatherRequestFactory
    let decoder: JSONDecoder
    
    public func forecast(for query: LocationQuery, days: Int) async throws -> Weather {
        let response: WeatherResponseDto = try await perform(.forecast(query, days: days))
        return response.toDomain()
    }
    
    public func search(_ text: String) async throws -> [CityMatch] {
        let response: [SearchResultDto] = try await perform(.search(text))
        return response.map { $0.toDomain() }
    }
    
    private func perform<T: Decodable & Sendable>(_ route: WeatherRoute) async throws -> T {
        do {
            let request = try factory.makeRequest(route: route)
            let response = try await session
                .request(request)
                .validate()
                .serializingDecodable(T.self, decoder: decoder)
                .value

            return response
        } catch {
            throw Self.map(error)
        }
    }

    private static func map(_ error: Error) -> WeatherError {
        let urlError = (error.asAFError?.underlyingError as? URLError) ?? (error as? URLError)
        if let urlError {
            switch urlError.code {
            case .notConnectedToInternet, .networkConnectionLost,
                 .cannotConnectToHost, .dataNotAllowed, .timedOut:
                return .offline
            default:
                break
            }
        }

        if case let .responseValidationFailed(reason) = error.asAFError,
           case let .unacceptableStatusCode(code) = reason,
           code == 400 {
            return .notfound
        }

        return .unknown(underlying: error)
    }
}
