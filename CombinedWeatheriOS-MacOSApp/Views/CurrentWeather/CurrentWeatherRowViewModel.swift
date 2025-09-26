//
//  CurrentWeatherRowViewModel.swift
//  CombinedWeatheriOS-MacOSApp
//
//  Created by Jonathan Mora on 25/09/25.
//
import SwiftUI

struct CurrentWeatherRowViewModel: Identifiable {
    private let item: ForecastItem
    
    var id: String {
        return item.dt_txt
    }
    
    var hour: String {
       
        if let date = apiFormatter.date(from: item.dt_txt) {
            return hourFormatter.string(from: date)
        } else {
            return "–"
        }
    }
    
    var temperature: String {
        return String(format: "%.1f", item.main.temp)
    }
    
    init(item: ForecastItem) {
        self.item = item
    }
}
