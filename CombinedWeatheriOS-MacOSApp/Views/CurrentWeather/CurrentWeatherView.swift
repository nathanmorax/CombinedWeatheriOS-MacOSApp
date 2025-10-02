//
//  ContentView.swift
//  CombinedWeatheriOS-MacOSApp
//
//  Created by Jonathan Mora on 23/09/25.
//

import SwiftUI
import MapKit
import Combine
import CoreLocation
#if os(iOS)
import CoreLocationUI
#endif

struct CurrentWeatherView: View {
    
    @StateObject var vm: CurrentWeatherViewModel
    @StateObject var locationManager = LocationManager()
    
    
    init() {
        let locationManager = LocationManager()
        _locationManager = StateObject(wrappedValue: locationManager)
        _vm = StateObject(wrappedValue: CurrentWeatherViewModel(weatherFetcher: WeatherFetcher(), locationManager: locationManager))
    }
    
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea(edges: .all)
            
            VStack {
                
                if let data = vm.dataSource {
                    locationDescription(weather: data)
                        .padding(.top, 42)
                }
                
                Spacer()
                
                
                if let forecastDay = vm.dataSource?.forecast.forecastday.first {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(forecastDay.hour, id: \.time) { hour in
                                let itemVM = CurrentWeatherRowViewModel(forecast: forecastDay, hour: hour)
                                CurrentWeatherRow(viewModel: itemVM)
                            }
                        }
                    }
                }
                
                
            }
            .padding()
        }
        .onReceive(locationManager.$location.compactMap { $0 }) { coordinate in
            print("Nueva ubicación: \(coordinate.latitude), \(coordinate.longitude)")
            vm.refresh(lat: coordinate.latitude, lon: coordinate.longitude)
            vm.hourlyWeather(lat: coordinate.latitude, lon: coordinate.longitude)
        }
        
        
        
    }
    
    @ViewBuilder
    func locationDescription(weather: WeatherResponse) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(weather.location.name)
                    .pixelFont(size: 36, bold: true)
                
                Text("\(Int(weather.current.temp_c))°C")
                    .pixelFont(size: 32)
                
                Text(weather.current.condition.text ?? "Desconocido")
                 .pixelFont(size: 30, bold: true)
                 .padding(12)
                 .background(.cyan)
            }
            
            Spacer()
            
            Image("Sun")
                .resizable()
                .interpolation(.none)
                .frame(width: 180, height: 180)
        }
    }
    
    
    private func formatHour(_ timeString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "HH:mm"
        
        if let date = inputFormatter.date(from: timeString) {
            return outputFormatter.string(from: date)
        }
        return timeString
    }
    
    
}

#Preview {
    CurrentWeatherView()
}
