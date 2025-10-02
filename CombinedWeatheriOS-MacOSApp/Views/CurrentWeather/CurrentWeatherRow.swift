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
        VStack {
            Text(viewModel.hour)
                .pixelFont(size: 18)
                .foregroundColor(.white)
            
            if let url = viewModel.iconURL {
                AsyncImage(url: url) { image in
                    image.resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 30, height: 30)
            }
            
            Text("\(viewModel.temperature)°")
                .pixelFont(size: 18, bold: true)
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
    
}
