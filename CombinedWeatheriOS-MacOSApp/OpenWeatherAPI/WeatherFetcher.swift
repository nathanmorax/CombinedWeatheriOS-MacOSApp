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
    
    func currentWeatherLocation(forLat lat: Double, forLong lon: Double) -> AnyPublisher<WeatherResponse, WeatherError>
}

class WeatherFetcher {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
}

extension WeatherFetcher: WeatherFetchable {
    
    func currentWeatherLocation(forLat lat: Double, forLong lon: Double) -> AnyPublisher<WeatherResponse, WeatherError> {
        return weatherFecth(with: makeForecastComponents(withLat: lat, withLon: lon))
    }
    
    func hourlyWeatherLocation(forLat lat: Double, forLong lon: Double) -> AnyPublisher<HourlyWeatherResponse, WeatherError> {
        return weatherFecth(with: makeForecastComponents(withLat: lat, withLon: lon))
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
    struct WeatherAPI {
         static let schema = "https"
         static let host = "api.weatherapi.com"
         static let pathForecast = "/v1/forecast.json"
         static let key = "130257e4ed154b0cb9d30427252809"
     }
     
     private func makeForecastComponents(withLat lat: Double, withLon lon: Double, days: Int = 1) -> URLComponents {
         var components = URLComponents()
         components.scheme = WeatherAPI.schema
         components.host = WeatherAPI.host
         components.path = WeatherAPI.pathForecast
         
         components.queryItems = [
             URLQueryItem(name: "key", value: WeatherAPI.key),
             URLQueryItem(name: "q", value: "\(lat),\(lon)"),
             URLQueryItem(name: "days", value: "\(days)"),
             URLQueryItem(name: "aqi", value: "no"),
             URLQueryItem(name: "alerts", value: "no")
         ]
         
         return components
     }
    
    /*private func makeHourlyLocationComponents(withLat lat: Double, withLon lon: Double) -> URLComponents {
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
    }*/
}

