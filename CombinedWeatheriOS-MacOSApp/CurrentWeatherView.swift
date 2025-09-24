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
        span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
    )
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea(edges: .all)
            
            VStack {
                
                locationDescription
                    .padding(.top, 42)
                
                Spacer()
                
                VStack {
                    Map(coordinateRegion: $region)
                        //.cornerRadius(25)
                        .frame(height: 300)
                        .disabled(true)
                    
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
    }
    
    init() {
        for familyName in UIFont.familyNames {
            print(familyName)
            for fontName in UIFont.fontNames(forFamilyName: familyName) {
                print("\t\(fontName)")
            }
        }
    }
    
    var locationDescription: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Tecomatlan")
                    .foregroundStyle(.white)
                    .font(.custom("PixelOperator-Bold", size: 42))
                    //.bold()
                
                Text("23°C")
                    .font(.custom("PixelOperator", size: 42))
                    .foregroundStyle(.white)
                
                Text("Nublado")
                    .font(.custom("PixelOperator", size: 42))
                    .foregroundStyle(.white)
            }
            
            Spacer()
            HStack {
                
                Image(systemName: "sun.max.fill")
                    .foregroundStyle(.yellow)
                    .font(.system(size: 100))
            }
         
      
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
