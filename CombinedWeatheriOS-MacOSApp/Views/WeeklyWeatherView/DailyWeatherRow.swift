//
//  DailyWeatherRow.swift
//  CombinedWeatheriOS-MacOSApp
//
//  Created by Jonathan Mora on 02/10/25.
//

import SwiftUI

struct DailyWeatherRow: View {
    private let viewModel: DailyWeatherRowViewModel
    
    init(viewModel: DailyWeatherRowViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack(spacing: 16) {
            HStack(spacing: 4) {
                Text(viewModel.day)
                    .pixelFont(size: 22, bold: true)
                Spacer()
                Text("🌡️ Máxima: \(viewModel.temperatureMax)°C / Mínima: \(viewModel.temperatureMin)°C")
                    .pixelFont(size: 16)
                Spacer()

                Text("🌧️ Prob. lluvia: \(viewModel.rain)%")
                    .pixelFont(size: 16)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 8)
        .padding(.horizontal, 8)

    }
}
