//
//  ContentView.swift
//  CombinedWeatheriOS-MacOSApp
//
//  Created by Jonathan Mora on 23/09/25.
//

import SwiftUI
import MapKit


struct CurrentWeatherView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 19.4326, longitude: -99.1332),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea(edges: .all)
            
            VStack {
                Text("Tecomatlan")
                    .foregroundStyle(.white)
                
                HStack {
                    Text("23°C")
                        .font(.title)
                        .foregroundStyle(.white)
                    
                    Image(systemName: "sun.max.fill")
                        .foregroundStyle(.yellow)
                        .font(.system(size: 60))
                }
                
                Text("Nublado")
                    .foregroundStyle(.white)
                
                Map(coordinateRegion: $region)
                    .frame(height: 300)
                    .cornerRadius(10)
                
                CurrentWeatherRowView()
            }
            .padding()
        }
    }
}

#Preview {
    CurrentWeatherView()
}

struct CurrentWeatherRowView: View {
    var body: some View {
        Text("CurrentWeatherRowView")
            .foregroundStyle(.white)

    }
}
