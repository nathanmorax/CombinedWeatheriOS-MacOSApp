//
//  WeeklyWeatherView.swift
//  CombinedWeatheriOS-MacOSApp
//
//  Created by Jonathan Mora on 02/10/25.
//

import SwiftUI
import CoreLocation
import Combine

struct WeeklyWeatherView: View {
    @ObservedObject var viewModel: WeeklyWeatherViewModel
    @StateObject var locationManager = LocationManager()
    
    init(viewModel: WeeklyWeatherViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            if viewModel.dataWeekly.isEmpty {
                Text("Cargando pronóstico…")
                    .padding()
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 12) {
                        ForEach(viewModel.dataWeekly, id: \.date) { day in
                            let rowVM = DailyWeatherRowViewModel(dailyItem: day)
                            DailyWeatherRow(viewModel: rowVM)
                        }
                    }
                    .padding()
                }
            }
        }
        .onReceive(locationManager.$location.compactMap { $0 }) { coordinate in
            print("Nueva ubicación: \(coordinate.latitude), \(coordinate.longitude)")
            viewModel.fetchWeeklyWeather(lat: coordinate.latitude, lon: coordinate.longitude)
        }

    }
}
