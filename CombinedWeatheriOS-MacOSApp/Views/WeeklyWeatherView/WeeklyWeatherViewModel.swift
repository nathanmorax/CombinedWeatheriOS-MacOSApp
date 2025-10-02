//
//  WeeklyWeatherViewModel.swift
//  CombinedWeatheriOS-MacOSApp
//
//  Created by Jonathan Mora on 02/10/25.
//
import Combine
import SwiftUI
import CoreLocation

class WeeklyWeatherViewModel: ObservableObject {
    
    @Published var dataWeekly: [ForecastDay] = []

    private let weatherFetcher: WeatherFetchable
    private var disposables = Set<AnyCancellable>()
    
    init(weatherFetcher: WeatherFetchable, locationManager: LocationManager) {
        self.weatherFetcher = weatherFetcher
        
        locationManager.$location
            .compactMap { $0 }
            .sink { [weak self] coordinate in
                self?.weatherFetcher.weeklyWeather(forLat: coordinate.latitude, forLong: coordinate.longitude)
            }
            .store(in: &disposables)
    }
    
    
    func fetchWeeklyWeather(lat: Double, lon: Double) {
        weatherFetcher
            .weeklyWeather(forLat: lat, forLong: lon)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .failure(let error):
                    print(error)
                    self.dataWeekly = []
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] weekly in
                
                self?.dataWeekly = weekly.forecast.forecastday
                print("Clima hoy: \(self?.dataWeekly)")
                
                
            })
            .store(in: &disposables)
        
    }
}
