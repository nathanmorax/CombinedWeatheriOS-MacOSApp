//
//  CurrentWeatherViewModel.swift
//  CombinedWeatheriOS-MacOSApp
//
//  Created by Jonathan Mora on 24/09/25.
//
import Combine
import Foundation
import CoreLocation

class CurrentWeatherViewModel: ObservableObject {
    @Published var dataSource: CurrentWeatherResponse?
    @Published var dataSourceHourly: [ForecastItem] = []
    
    
    private let weatherFetcher: WeatherFetcher
    
    private var disposables = Set<AnyCancellable>()
    
    init(weatherFetcher: WeatherFetcher, locationManager: LocationManager) {
        self.weatherFetcher = weatherFetcher
        
        
        locationManager.$location
            .compactMap { $0 }
            .sink { [weak self] coordinate in
                self?.weatherFetcher.currentWeatherLocation(forLat: coordinate.latitude, forLong: coordinate.longitude)
            }
            .store(in: &disposables)
    }
    
    func refresh(lat: Double, lon: Double) {
        weatherFetcher
            .currentWeatherLocation(forLat: lat, forLong: lon)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                
                switch completion {
                case .failure(let error):
                    print("Error API:", error)
                    self.dataSource = nil
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] weather in
                self?.dataSource = weather
                print(weather)
            })
            .store(in: &disposables)
        
        print(lat)
        print(lon)
        
    }
    
    func hourlyWeather(lat: Double, lon: Double) {
        weatherFetcher
            .hourlyWeatherLocation(forLat: lat, forLong: lon)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .failure(let error):
                    print(error)
                    self.dataSourceHourly = []
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] hourlyWeather in
                
                self?.dataSourceHourly = hourlyWeather.list.filteredForToday()

                print("Clima hoy: \(self?.dataSourceHourly)")
                
                
            })
            .store(in: &disposables)
        
    }
}

extension Array where Element == ForecastItem {
    func filteredForToday() -> [ForecastItem] {
        let now = Date()
        let calendar = Calendar.current
        
        return self.filter { item in
            guard let localDate = item.dateLocal else { return false }
            return calendar.isDate(localDate, inSameDayAs: now)
        }
    }
}

extension ForecastItem {
    var dateLocal: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = TimeZone(secondsFromGMT: 0) // UTC
        return formatter.date(from: dt_txt) // Date ya representa el instante correcto
    }
}


