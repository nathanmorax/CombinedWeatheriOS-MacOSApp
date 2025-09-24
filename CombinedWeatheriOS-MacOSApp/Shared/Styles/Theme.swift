//
//  Theme.swift
//  CombinedWeatheriOS-MacOSApp
//
//  Created by Jonathan Mora on 23/09/25.
//
import SwiftUI

struct AppColors {
    static let primary = Color.teal
    static let textPrimary = Color.white
}

struct AppFonts {
    static func pixel(size: CGFloat, bold: Bool = false) -> Font {
        .custom(bold ? "PixelOperator-Bold" : "PixelOperator", size: size)
    }
}

struct AppSpacing {
    static let small: CGFloat = 8
    static let medium: CGFloat = 16
    static let large: CGFloat = 24
}
