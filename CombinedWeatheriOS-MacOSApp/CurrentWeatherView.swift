//
//  ContentView.swift
//  CombinedWeatheriOS-MacOSApp
//
//  Created by Jonathan Mora on 23/09/25.
//

import SwiftUI
import MapKit
import Combine


struct CurrentWeatherView: View {
    
    @ObservedObject var vm = CurrentWeatherViewModel(weatherFetcher: WeatherFetcher(), lat: 19.381962, lon: -99.181042)
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea(edges: .all)
            
            VStack {
                
                if let data = vm.dataSource {
                    locationDescription(weather: data)
                        .padding(.top, 42)
                } else {
                    ProgressView("Cargando clima...")
                        .foregroundColor(.white)
                        .padding(.top, 42)
                }
                
                Spacer()
                
                VStack {
                    HStack {
                        CurrentWeatherRowView()
                        CurrentWeatherRowView()
                        CurrentWeatherRowView()
                        CurrentWeatherRowView()
                        CurrentWeatherRowView()
                    }
                    
                    
                }
                
                
                
            }
            .padding()
        }
        .onAppear {
            vm.refresh()
        }
    }
    
    @ViewBuilder
    func locationDescription(weather: CurrentWeatherResponse) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(weather.name)
                    .pixelFont(size: 36, bold: true)
                
                Text("\(Int(weather.main.temp))°C")
                 .pixelFont(size: 32)
                
                Text(weather.weather.first?.description.capitalized ?? "Desconocido")
                    .pixelFont(size: 30, bold: true)
                    .padding(12)
                    .background(.cyan)
            }
            
            Spacer()
            
            Image("Sun")
                .resizable()
                .interpolation(.none)
                .frame(width: 180, height: 180)
        }
    }
}

#Preview {
    CurrentWeatherView()
}

struct CurrentWeatherRowView: View {
    var body: some View {
        VStack(spacing: 12) {
            
            HStack {
                Text("1:00 pm")
                    .foregroundStyle(.white)
            }
            
            HStack {
                Image(systemName: "sun.max.fill")
                    .foregroundStyle(.yellow)
                
            }
            
            HStack {
                Text("23°C")
                    .foregroundStyle(.white)
                
            }
        }
        .background(.brown)
        .frame(maxWidth: 100)
        
    }
}

