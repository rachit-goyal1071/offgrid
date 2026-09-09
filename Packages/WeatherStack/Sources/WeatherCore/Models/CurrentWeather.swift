public struct CurrentWeather: Sendable {
    public let tempC: Double
    public let tempF: Double
    public let isDay: Bool
    public let condition: WeatherCondition
    public let windKph: Double
    public let humidity: Int
    public let feelslikeC: Double
    public let feelslikeF: Double
    public let uv: Double
    public let chanceOfRain: Int
    public let scene: WeatherSceneKind
}
