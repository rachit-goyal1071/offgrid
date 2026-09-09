public struct Weather: Sendable {
    public let location: Location
    public let current: CurrentWeather
    public let forecast: Forecast?
}
