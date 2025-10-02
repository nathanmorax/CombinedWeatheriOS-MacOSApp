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
    formatter.dateFormat = "h a"
    formatter.amSymbol = "AM"
    formatter.pmSymbol = "PM"
    formatter.timeZone = TimeZone.current
    return formatter
}()

let dayOfWeekFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "EEEE" // nombre completo del día (ej. Martes)
    formatter.locale = Locale(identifier: "es_MX") // asegura español
    formatter.timeZone = TimeZone.current
    return formatter
}()

let dayOnlyFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    formatter.timeZone = TimeZone.current
    return formatter
}()


