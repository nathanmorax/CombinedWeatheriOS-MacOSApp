//
//  Formatters.swift
//  CombinedWeatheriOS-MacOSApp
//
//  Created by Jonathan Mora on 25/09/25.
//
import SwiftUI

let apiFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    return formatter
}()

let hourFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm"
    return formatter
}()
