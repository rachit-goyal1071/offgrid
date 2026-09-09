public enum WeatherSceneKind: String, Sendable {
    case clear
    case partlyCloudy
    case cloudy
    case fog
    case rain
    case snow
    case storm
}

public extension WeatherSceneKind {
    
    static func from(code: Int) -> WeatherSceneKind {
        switch code {
        case 1000: return .clear
        case 1003: return .partlyCloudy
        case 1006, 1009: return .cloudy
        case 1030, 1135, 1147: return .fog
        case 1063, 1150, 1153, 1180, 1183, 1186, 1189, 1192, 1195,
             1240, 1243, 1246, 1198, 1201, 1168, 1171: return .rain
        case 1066, 1069, 1072, 1114, 1117, 1210, 1213, 1216, 1219,
             1222, 1225, 1237, 1249, 1252, 1255, 1258, 1261, 1264: return .snow
        case 1087, 1273, 1276, 1279, 1282: return .storm
        default: return .clear
        }
    }
}
