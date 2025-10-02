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
            ScrollView(.vertical, showsIndicators: false) {
                
                if viewModel.dataWeekly.isEmpty {
                    Text("Cargando pronóstico…")
                } else {
                    ForEach(viewModel.dataWeekly, id: \.date) { day in
                        let rowVM = DailyWeatherRowViewModel(dailyItem: day)
                        DailyWeatherRow(viewModel: rowVM)
                        Divider()
                    }
                    
                }
            }
            .onReceive(locationManager.$location.compactMap { $0 }) { coordinate in
                print("Nueva ubicación: \(coordinate.latitude), \(coordinate.longitude)")
                viewModel.fetchWeeklyWeather(lat: coordinate.latitude, lon: coordinate.longitude)
            }
        }
    }
}




struct DailyWeatherRow: View {
    private let viewModel: DailyWeatherRowViewModel
    
    init(viewModel: DailyWeatherRowViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(viewModel.day)
                .pixelFont(size: 18)
            Text("🌡️ Máxima: \(viewModel.temperatureMax)°C / Mínima: \(viewModel.temperatureMin)°C")
                .pixelFont(size: 18)

            Text("🌧️ Prob. lluvia: \(viewModel.rain)%")
                .pixelFont(size: 18)

        }
    }
}


struct DailyWeatherRowViewModel: Identifiable {
    private let dailyItem: ForecastDay
    
    var id: String {
        return dailyItem.date
    }
    
    var day: String {
        if let date = dayOnlyFormatter.date(from: dailyItem.date) {
            return dayOfWeekFormatter.string(from: date)
        }
        return dailyItem.date
    }
    
    var temperatureMax: String {
        return String(format: "%.1f", Double(dailyItem.day.maxtemp_c))
    }

    var temperatureMin: String {
        return String(format: "%.1f", Double(dailyItem.day.mintemp_c))
    }

    var rain: String {
        return String(format: "%.1f", Double(dailyItem.day.daily_chance_of_rain))
    }

    
   /* var iconURL: URL? {
        return URL(string: "https:\(hourItem.condition.icon)")
    }*/
    
    init(dailyItem: ForecastDay) {
        self.dailyItem = dailyItem
    }
}
