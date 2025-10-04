//
//  WeatherIcon.swift
//  CombinedWeatheriOS-MacOSApp
//
//  Created by Jonathan Mora on 03/10/25.
//

enum WeatherIcon: Int {
    case sunny = 1000
    case partlyCloudy = 1003
    case cloudy = 1006
    case overcast = 1009
    case mist = 1030
    case patchyRain = 1063
    case rain = 1183
    case snow = 1210

    var imageName: String {
        switch self {
        case .sunny: return "sunny"
        case .partlyCloudy: return "icon_partly_cloudy"
        case .cloudy: return "icon_cloudy"
        case .overcast: return "icon_overcast"
        case .mist: return "icon_mist"
        case .patchyRain, .rain: return "icon_rain"
        case .snow: return "icon_snow"
        }
    }
}
