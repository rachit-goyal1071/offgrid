import Foundation

// MARK: - Current Weather Response

nonisolated struct WeatherResponseDto: Codable {
    let location: LocationDto
    let current: CurrentWeatherDto
    let forecast: ForecastDto?
}

extension WeatherResponseDto {
    
    nonisolated func toDomain() -> Weather {
        Weather(
            location: location.toDomain(),
            current: current.toDomain(),
            forecast: forecast?.toDomain()
        )
    }
}

struct LocationDto: Codable, Hashable {
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double
    let localtimeEpoch: Int
    let tzId: String
}

extension LocationDto {
    
    nonisolated func toDomain() -> Location {
        Location(
            name: name,
            region: region,
            country: country,
            lat: lat,
            lon: lon,
            localtime: {
                let date = Date(timeIntervalSince1970: TimeInterval(localtimeEpoch))
                let formatter = DateFormatter()
                formatter.dateFormat = "EEE, MMM d"
                formatter.timeZone = TimeZone(identifier: tzId)
                return formatter.string(from: date)
            }()
        )
    }
}

struct CurrentWeatherDto: Codable {
    let tempC: Double
    let tempF: Double
    let isDay: Int
    let condition: WeatherConditionDto
    let windKph: Double
    let humidity: Int
    let feelslikeC: Double
    let feelslikeF: Double
    let uv: Double
    let chanceOfRain: Int
}

extension CurrentWeatherDto {
    
    nonisolated func toDomain() -> CurrentWeather {
        
        CurrentWeather(
            tempC: tempC,
            tempF: tempF,
            isDay: isDay == 1,
            condition: condition.toDomain(),
            windKph: windKph,
            humidity: humidity,
            feelslikeC: feelslikeC,
            feelslikeF: feelslikeF,
            uv: uv,
            chanceOfRain: chanceOfRain,
            scene: WeatherSceneKind.from(code: condition.code)
        )
    }
}

struct WeatherConditionDto: Codable, Hashable {
    let text: String
    let icon: String
    let code: Int
}

extension WeatherConditionDto {
    
    nonisolated func toDomain() -> WeatherCondition {
        
        WeatherCondition(
            text: text,
            code: code,
            iconURL: URL(string: "https:\(icon)")
        )
    }
}

// MARK: - Forecast (multi-day)

struct ForecastDto: Codable {
    let forecastday: [ForecastDayDto]
}

extension ForecastDto {
    
    nonisolated func toDomain() -> Forecast{
        Forecast(
            forecastdays: forecastday.map { $0.toDomain() }
        )
    }
}

struct ForecastDayDto: Codable, Identifiable {
    let date: String
    let dateEpoch: Int
    let day: DayForecastDto
    
    nonisolated var id: String { date }
}

extension ForecastDayDto {
    
    nonisolated func toDomain() -> ForecastDay {
        ForecastDay(
            date: {
                let date = Date(timeIntervalSince1970: TimeInterval(dateEpoch))
                let formatter = DateFormatter()
                formatter.dateFormat = "EEE, MMM d"
                return formatter.string(from: date)
            }(),
            day: day.toDomain(),
            id: id
        )
    }
}

struct DayForecastDto: Codable {
    let maxtempC: Double
    let mintempC: Double
    let avgtempC: Double
    let dailyChanceOfRain: Int
    let condition: WeatherConditionDto
}

extension DayForecastDto {
    
    nonisolated func toDomain() -> DayForecast {
        DayForecast(
            maxtempC: maxtempC,
            mintempC: mintempC,
            avgtempC: avgtempC,
            dailyChanceOfRain: dailyChanceOfRain,
            condition: condition.toDomain()
        )
    }
}

// MARK: - Search Result

nonisolated struct SearchResultDto: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double
}

extension SearchResultDto {
    
    nonisolated func toDomain() -> CityMatch {
        CityMatch(
            id: id,
            name: name,
            country: country,
            region: region,
            latitude: lat,
            longitude: lon
        )
    }
}
