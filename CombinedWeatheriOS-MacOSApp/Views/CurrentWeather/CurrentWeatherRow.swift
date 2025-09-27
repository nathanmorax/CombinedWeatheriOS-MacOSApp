//
//  CurrentWeatherRow.swift
//  CombinedWeatheriOS-MacOSApp
//
//  Created by Jonathan Mora on 25/09/25.
//
import SwiftUI

struct CurrentWeatherRow: View {
    
    
    private let viewModel: CurrentWeatherRowViewModel
    
    init(viewModel: CurrentWeatherRowViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack {
            Text(viewModel.hour)
                .pixelFont(size: 18)
                .foregroundColor(.white)
            
            Spacer()
            
            Text("\(viewModel.temperature)°")
                .pixelFont(size: 18, bold: true)
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
    
}
