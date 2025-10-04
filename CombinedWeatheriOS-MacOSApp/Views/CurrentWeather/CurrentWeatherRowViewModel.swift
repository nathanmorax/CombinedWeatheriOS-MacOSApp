//
//  CurrentWeatherRowViewModel.swift
//  CombinedWeatheriOS-MacOSApp
//
//  Created by Jonathan Mora on 25/09/25.
//
import SwiftUI

struct CurrentWeatherRowViewModel: Identifiable {
    private let forecastItem: ForecastDay
    private let hourItem: Hour
    
    var id: String {
        return forecastItem.date + "_" + hourItem.time
    }
    
    var hour: String {
        if let date = apiFormatter.date(from: hourItem.time) {
            return hourFormatter.string(from: date)
        } else {
            return hourItem.time
        }
    }
    
    var temperature: String {
        return String(format: "%.1f", hourItem.temp_c)
    }
    
    var iconURL: URL? {
        return URL(string: "https:\(hourItem.condition.icon)")
    }
    
    var iconCode: Int {
        return hourItem.condition.code
    }
    
    
    init(forecast: ForecastDay, hour: Hour) {
        self.forecastItem = forecast
        self.hourItem = hour
    }
}

