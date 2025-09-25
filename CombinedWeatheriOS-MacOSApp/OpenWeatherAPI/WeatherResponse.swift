//
//  WeatherResponse.swift
//  CombinedWeatheriOS-MacOSApp
//
//  Created by Jonathan Mora on 24/09/25.
//

import Foundation

// MARK: - Shared Base Models
// Estas estructuras son compartidas entre ambos endpoints
struct Coord: Codable {
    let lon: Double
    let lat: Double
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
    let sea_level: Int?
    let grnd_level: Int?
    
    // Propiedades específicas del forecast (opcionales para current weather)
    let temp_kf: Double?
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double?
}

struct Clouds: Codable {
    let all: Int
}

// MARK: - Current Weather Specific Models
struct CurrentWeatherSys: Codable {
    let country: String
    let sunrise: Int
    let sunset: Int
}

// MARK: - Forecast Specific Models
struct ForecastSys: Codable {
    let pod: String // "d" for day, "n" for night
}

struct ForecastItem: Codable {
    let dt: Int
    let main: Main
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let visibility: Int
    let pop: Double // Probability of precipitation
    let rain: Rain?
    let sys: ForecastSys
    let dt_txt: String
}

struct Rain: Codable {
    let threeH: Double // 3 hour rainfall
    
    private enum CodingKeys: String, CodingKey {
        case threeH = "3h"
    }
}

struct City: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population: Int
    let timezone: Int
    let sunrise: Int
    let sunset: Int
}

// MARK: - Response Models
struct CurrentWeatherResponse: Codable {
    let coord: Coord
    let weather: [Weather]
    let base: String?
    let main: Main
    let visibility: Int?
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: CurrentWeatherSys
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
}

struct HourlyWeatherResponse: Codable {
    let cod: String
    let message: Int
    let cnt: Int
    let list: [ForecastItem]
    let city: City
}
