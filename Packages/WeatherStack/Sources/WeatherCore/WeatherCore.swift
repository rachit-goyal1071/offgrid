import Foundation

public enum WeatherStack {
    
    public static func makeRepository(config: WeatherConfig) -> WeatherRepository {
        
        let weatherDecoder: JSONDecoder = {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return decoder
        }()
        
        return WeatherRepositoryImpl(
            session: WeatherSession.make(config: config),
            factory: WeatherRequestFactory(config: config),
            decoder: weatherDecoder
        )
    }
}


