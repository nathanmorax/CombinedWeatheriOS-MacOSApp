//
//  DailyWeatherRowViewModel.swift
//  CombinedWeatheriOS-MacOSApp
//
//  Created by Jonathan Mora on 02/10/25.
//
import SwiftUI

struct DailyWeatherRowViewModel: Identifiable {
    private let dailyItem: ForecastDay
    
    init(dailyItem: ForecastDay) {
        self.dailyItem = dailyItem
    }
    
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
}
