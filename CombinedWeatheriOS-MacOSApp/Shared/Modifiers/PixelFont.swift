//
//  PixelFont.swift
//  CombinedWeatheriOS-MacOSApp
//
//  Created by Jonathan Mora on 23/09/25.
//

import SwiftUI

import SwiftUI

struct PixelFontModifier: ViewModifier {
    let size: CGFloat
    let bold: Bool

    func body(content: Content) -> some View {
        content
            .font(AppFonts.pixel(size: size, bold: bold))
            .foregroundStyle(.white) 
    }
}

extension View {
    func pixelFont(size: CGFloat, bold: Bool = false) -> some View {
        self.modifier(PixelFontModifier(size: size, bold: bold))
    }
}

