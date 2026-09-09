import SwiftUI

struct WeatherPalette {
    let top: Color
    let middle: Color
    let bottom: Color
    
    let foreground: Color = .white
    
    var gradient: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [top, middle, bottom]), startPoint: .top, endPoint: .bottom)
    }
}

extension WeatherPalette {
    
        static let clearDay = WeatherPalette(
            top: Color(red: 0.49, green: 0.77, blue: 1.00),
            middle: Color(red: 0.31, green: 0.64, blue: 0.97),
            bottom: Color(red: 0.18, green: 0.48, blue: 0.84)
        )
        
        static let partlyCloudyDay = WeatherPalette(
            top: Color(red: 0.61, green: 0.79, blue: 0.95),
            middle: Color(red: 0.42, green: 0.66, blue: 0.89),
            bottom: Color(red: 0.31, green: 0.53, blue: 0.79)
        )
        
        static let cloudy = WeatherPalette(
            top: Color(red: 0.54, green: 0.60, blue: 0.67),
            middle: Color(red: 0.40, green: 0.46, blue: 0.53),
            bottom: Color(red: 0.28, green: 0.33, blue: 0.40)
        )
        
        static let rainy = WeatherPalette(
            top: Color(red: 0.36, green: 0.42, blue: 0.49),
            middle: Color(red: 0.25, green: 0.29, blue: 0.36),
            bottom: Color(red: 0.16, green: 0.20, blue: 0.25)
        )
        
        static let snowy = WeatherPalette(
            top: Color(red: 0.72, green: 0.77, blue: 0.84),
            middle: Color(red: 0.54, green: 0.60, blue: 0.67),
            bottom: Color(red: 0.37, green: 0.42, blue: 0.49)
        )
        
        static let stormy = WeatherPalette(
            top: Color(red: 0.24, green: 0.22, blue: 0.28),
            middle: Color(red: 0.16, green: 0.15, blue: 0.20),
            bottom: Color(red: 0.09, green: 0.08, blue: 0.11)
        )
        
        static let fog = WeatherPalette(
            top: Color(red: 0.65, green: 0.68, blue: 0.72),
            middle: Color(red: 0.50, green: 0.53, blue: 0.58),
            bottom: Color(red: 0.36, green: 0.39, blue: 0.43)
        )
        
        static let clearNight = WeatherPalette(
            top: Color(red: 0.05, green: 0.11, blue: 0.20),
            middle: Color(red: 0.04, green: 0.07, blue: 0.15),
            bottom: Color(red: 0.02, green: 0.03, blue: 0.10)
        )
}

extension WeatherPalette {
    
    static func forCondition(code: Int, isDay: Bool) -> WeatherPalette {
            switch code {
            case 1000:
                return isDay ? .clearDay : .clearNight
            case 1003:
                return isDay ? .partlyCloudyDay : .clearNight
            case 1006, 1009:
                return .cloudy
            case 1030, 1135, 1147:
                return .fog
            case 1063, 1150, 1153, 1180, 1183, 1186, 1189, 1192, 1195,
                 1240, 1243, 1246, 1198, 1201, 1168, 1171:
                return .rainy
            case 1066, 1069, 1072, 1114, 1117, 1210, 1213, 1216, 1219,
                 1222, 1225, 1237, 1249, 1252, 1255, 1258, 1261, 1264:
                return .snowy
            case 1087, 1273, 1276, 1279, 1282:
                return .stormy
            default:
                return isDay ? .clearDay : .clearNight
            }
        }
}
