import Foundation

public enum LocationQuery: Equatable, Hashable, Sendable {
    
    case name(String)
    case coordinates(latitude: Double, longitude: Double)

    var q: String {
        switch self {
        case .name(let name):
            name
        case .coordinates(let latitude, let longitude):
            String(format: "%.4f,%.4f", latitude, longitude)
        }
    }
}
