//
//  LocationManager.swift
//  CombinedWeatheriOS-MacOSApp
//
//  Created by Jonathan Mora on 24/09/25.
//

import CoreLocation
import CoreLocationUI
import Combine

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    @Published var location: CLLocationCoordinate2D?
    @Published var authorizationStatus: CLAuthorizationStatus

    override init() {
        self.authorizationStatus = manager.authorizationStatus
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
    }

    func requestLocation() {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.requestLocation()   // OK
        case .notDetermined:
            manager.requestWhenInUseAuthorization() // aún no decidido
        case .denied, .restricted:
            print("Ubicación denegada o restringida")
        @unknown default:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coord = locations.first?.coordinate else { return }
        print("Ubicación actual: \(coord.latitude), \(coord.longitude)")
        location = coord
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error ubicación:", error.localizedDescription)
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
        if authorizationStatus == .authorizedWhenInUse || authorizationStatus == .authorizedAlways {
            manager.requestLocation()
        }
    }
}



