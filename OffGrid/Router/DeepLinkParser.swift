import Foundation

enum DeepLink {
    case mapScreen
}

enum DeepLinkParser {
    
    static func parse(_ url: URL) -> DeepLink? {
        let parts = url.path.split(separator: "/")
        switch (url.host, parts.first) {
        case ("mapScreen", _): return .mapScreen
        default: return nil
        }
    }
}
