//
//  Formatters.swift
//  CombinedWeatheriOS-MacOSApp
//
//  Created by Jonathan Mora on 25/09/25.
//
import SwiftUI

let apiFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm"
    formatter.timeZone = TimeZone.current
    return formatter
}()


let hourFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "h a"    // 12h con AM/PM
    formatter.amSymbol = "AM"
    formatter.pmSymbol = "PM"
    formatter.timeZone = TimeZone.current // Muestra hora local correctamente
    return formatter
}()


