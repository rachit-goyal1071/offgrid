import Foundation

public struct WeatherCondition: Sendable {
    public let text: String
    public let code: Int
    public let iconURL: URL?
}
