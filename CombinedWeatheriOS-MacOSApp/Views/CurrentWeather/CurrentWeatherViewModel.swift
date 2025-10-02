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
    @Published var dataSource: WeatherResponse?
    
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
        
    }
}
