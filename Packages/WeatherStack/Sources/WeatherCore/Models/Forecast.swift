public struct Forecast: Sendable {
    public let forecastdays: [ForecastDay]
}

public struct ForecastDay: Sendable {
    public let date: String
    public let day: DayForecast
    public let id: String
}

public struct DayForecast: Sendable {
    public let maxtempC: Double
    public let mintempC: Double
    public let avgtempC: Double
    public let dailyChanceOfRain: Int
    public let condition: WeatherCondition
}
