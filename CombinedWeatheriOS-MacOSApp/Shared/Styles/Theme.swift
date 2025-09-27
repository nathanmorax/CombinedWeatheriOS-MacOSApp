//
//  Theme.swift
//  CombinedWeatheriOS-MacOSApp
//
//  Created by Jonathan Mora on 23/09/25.

import SwiftUI
#if os(macOS)
import AppKit
#endif

struct AppColors {
    static let primary = Color.teal
    static let textPrimary = Color.white
}

struct AppFonts {
    static func pixel(size: CGFloat, bold: Bool = false) -> Font {
        let fontName = bold ? "PixelOperator-Bold" : "PixelOperator"
        
        #if os(macOS)
        if NSFont(name: fontName, size: size) != nil {
            return .custom(fontName, size: size)
        } else {
            print("⚠️ Fuente '\(fontName)' no disponible en macOS, usando sistema")
            return .system(size: size, weight: bold ? .bold : .regular, design: .monospaced)
        }
        #else
        return .custom(fontName, size: size)
        #endif
    }
}

