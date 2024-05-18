//
//  Map.swift
//  TripSafe
//
//  Created by Gabriel Moosmann Mendez on 2024-02-23.
//

import SwiftUI
import MapKit
import Network

struct MapView: View {
    private let locationManager = CLLocationManager()
    @State private var updateLocation: Bool = true
    @State private var position: MapCameraPosition = .userLocation(followsHeading: false, fallback: .automatic)
    @State private var latitude: Float = 0.0
    @State private var longitude: Float = 0.0
    @State private var networkMonitor = NWPathMonitor()
    @Binding var userLocation: String
    
    // REQUIRES: lm - a CLLocationManager object
    // EFFECTS: If successful, updates user's current country location, otherwise does nothing
    // MODIFIES: userLocation
    func getCurrCountry(lm: CLLocationManager) {
        if let lastLocation = lm.location {
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(lastLocation, completionHandler: { (placemarks, error) in
                if error == nil {
                    if let firstLocation = placemarks?[0] {
                        userLocation = firstLocation.country ?? userLocation
                        print(userLocation)
                    } else {
                        print("Failed to find location")
                    }
                }
            })
        }
    }

    var body: some View {
        ZStack {
            Map(position: $position, interactionModes: .zoom) {
                UserAnnotation()
            }.onAppear() {
                locationManager.requestWhenInUseAuthorization()
                getCurrCountry(lm: locationManager)
                networkMonitor.pathUpdateHandler = { path in
                    if (path.status == .unsatisfied) {
                        userLocation = ""
                    }
                }
                networkMonitor.start(queue: DispatchQueue.main)
            }.onMapCameraChange { mapCameraUpdateContext in
                latitude = Float(mapCameraUpdateContext.camera.centerCoordinate.latitude)
                longitude = Float(mapCameraUpdateContext.camera.centerCoordinate.longitude)
                if (updateLocation) {
                    getCurrCountry(lm: locationManager)
                }
                updateLocation.toggle()
            }
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text("Lon: " + String(longitude))
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                        .padding(EdgeInsets(top: 2.0, leading: 4.0, bottom: 2.0, trailing: 4.0))
                        .background(.background).cornerRadius(4)
                        .padding(12)
                    Text("Lat: " + String(latitude))
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                        .padding(EdgeInsets(top: 2.0, leading: 4.0, bottom: 2.0, trailing: 4.0))
                        .background(.background).cornerRadius(4)
                        .padding(12)
                }
            }
        }
    }
}
