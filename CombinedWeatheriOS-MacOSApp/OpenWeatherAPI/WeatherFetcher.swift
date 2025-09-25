//
//  WeatherFetcher.swift
//  CombinedWeatheriOS-MacOSApp
//
//  Created by Jonathan Mora on 24/09/25.
//

import Foundation
import Combine

enum WeatherError: Error {
    case parsing(description: String)
    case network(description: String)
}

protocol WeatherFetchable {
    
    func currentWeatherLocation(forLat lat: Double, forLong lon: Double) -> AnyPublisher<CurrentWeatherResponse, WeatherError>
}

class WeatherFetcher {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
}

extension WeatherFetcher: WeatherFetchable {
    
    func currentWeatherLocation(forLat lat: Double, forLong lon: Double) -> AnyPublisher<CurrentWeatherResponse, WeatherError> {
        return weatherFecth(with: makeCurrentLocationComponents(withLat: lat, withLon: lon))
    }
    
    func hourlyWeatherLocation(forLat lat: Double, forLong lon: Double) -> AnyPublisher<HourlyWeatherResponse, WeatherError> {
        return weatherFecth(with: makeHourlyLocationComponents(withLat: lat, withLon: lon))
    }
    
    private func weatherFecth<T>(with components: URLComponents) -> AnyPublisher<T, WeatherError> where T: Decodable {
        guard let url = components.url else {
            let error = WeatherError.network(description: "Invalid URL components")
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: URLRequest(url: url))
            .mapError { error in
                    .network(description: error.localizedDescription)
            }
            .flatMap(maxPublishers: .max(1)) { pair in
                decode(pair.data)
            }
            .eraseToAnyPublisher()
    }
}


private extension WeatherFetcher {
    struct OpenWeatherAPI {
        static let schema = "https"
        static let host = "api.openweathermap.org"
        static let path = "/data/2.5/weather"
        static let pathHourly = "/data/2.5/forecast"
        static let key = "1011a0bb76d2ef4fd22aed0724b594c6"
    }
    
    private func makeCurrentLocationComponents(withLat lat: Double, withLon lon: Double) -> URLComponents {
        var components = URLComponents()
        components.scheme = OpenWeatherAPI.schema
        components.host = OpenWeatherAPI.host
        components.path = OpenWeatherAPI.path
        
        components.queryItems = [
            URLQueryItem(name: "lat", value: String(lat)),
            URLQueryItem(name: "lon", value: String(lon)),
            URLQueryItem(name: "appid", value: OpenWeatherAPI.key),
            URLQueryItem(name: "units", value: "metric"), // opcional: para °C
            URLQueryItem(name: "lang", value: "es")       // opcional: idioma en español
        ]
        
        return components
    }
    
    private func makeHourlyLocationComponents(withLat lat: Double, withLon lon: Double) -> URLComponents {
        var components = URLComponents()
        components.scheme = OpenWeatherAPI.schema
        components.host = OpenWeatherAPI.host
        components.path = OpenWeatherAPI.pathHourly
        
        components.queryItems = [
            URLQueryItem(name: "lat", value: String(lat)),
            URLQueryItem(name: "lon", value: String(lon)),
            URLQueryItem(name: "appid", value: OpenWeatherAPI.key),
            URLQueryItem(name: "units", value: "metric"), // opcional: para °C
            URLQueryItem(name: "lang", value: "es")
        ]
        
        return components
    }
}

