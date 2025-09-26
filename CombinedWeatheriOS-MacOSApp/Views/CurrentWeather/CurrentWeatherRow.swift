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
                    .foregroundColor(.white)
                    .font(.subheadline)

            Spacer()

            Text("\(viewModel.temperature)°")
                .foregroundColor(.cyan)
                .bold()
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }

}
