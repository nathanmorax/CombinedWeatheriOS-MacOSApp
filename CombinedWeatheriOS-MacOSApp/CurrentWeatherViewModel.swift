//
//  CurrentWeatherViewModel.swift
//  CombinedWeatheriOS-MacOSApp
//
//  Created by Jonathan Mora on 24/09/25.
//
import Combine
import Foundation

class CurrentWeatherViewModel: ObservableObject {
    @Published var dataSource: CurrentWeatherResponse?
    
    let lat: Double
    let lon: Double
    
    private let weatherFetcher: WeatherFetcher
    private var disposables = Set<AnyCancellable>()
    
    init(weatherFetcher: WeatherFetcher, lat: Double, lon: Double) {
        self.lat = lat
        self.lon = lon
        self.weatherFetcher = weatherFetcher
    }
    
    func refresh() {
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
            })
            .store(in: &disposables)
    }
}
