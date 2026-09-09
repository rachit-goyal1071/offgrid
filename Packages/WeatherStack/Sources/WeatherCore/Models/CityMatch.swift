import Foundation

public struct CityMatch: Identifiable, Sendable {
    public let id: Int
    public let name: String
    public let country: String
    public let region: String
    public let latitude: Double
    public let longitude: Double
}
