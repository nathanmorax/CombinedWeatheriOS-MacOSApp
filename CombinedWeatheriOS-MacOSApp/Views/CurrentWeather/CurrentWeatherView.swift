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
    @StateObject var weeklyVM = WeeklyWeatherViewModel(
        weatherFetcher: WeatherFetcher(),
        locationManager: LocationManager()
    )
    
    
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
                        .padding(.top, 22)
                }
                
                Spacer().frame(maxHeight: 44)
                
                
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
                
                Spacer().frame(maxHeight: 24)

                
                WeeklyWeatherView(viewModel: weeklyVM)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.cyan)
                            .shadow(radius: 8)
                    )

            }
            .padding()
        }
        .onReceive(locationManager.$location.compactMap { $0 }) { coordinate in
            print("Nueva ubicación: \(coordinate.latitude), \(coordinate.longitude)")
            vm.refresh(lat: coordinate.latitude, lon: coordinate.longitude)
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
            }
            
            Spacer()
            
            if let icon = WeatherIcon(rawValue: weather.current.condition.code) {
                Image(icon.imageName)
                    .resizable()
                    .interpolation(.none)
                    .frame(width: 180, height: 180)
            } else {
                Image("icon_default") // fallback
            }
                
        }
    }
    
}

#Preview {
    CurrentWeatherView()
}
