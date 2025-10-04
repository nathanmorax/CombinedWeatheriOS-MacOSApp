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
            
            if let icon = WeatherIcon(rawValue: viewModel.iconCode) {
                Image(icon.imageName)
                    .resizable()
                    .interpolation(.none)
                    .frame(width: 30, height: 30)
            } else {
                Image("icon_default") // fallback
            }
            
            /*if let url = viewModel.iconURL {
                AsyncImage(url: url) { image in
                    image.resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 30, height: 30)
            }*/
            
            Text("\(viewModel.temperature)°")
                .pixelFont(size: 18, bold: true)
        }
        .padding()
    }
    
}
