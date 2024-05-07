//
//  ContentView.swift
//  TripSafe
//
//  Created by Gabriel Moosmann Mendez on 2024-02-07.
//

import SwiftUI
import TabularData
import MapKit

struct ContentView: View {
    @Environment(\.dismiss) var dismiss
    
    private var countryData: [String : Country]
    private var countryNames: [String]
    var usesLocation: Bool = true
    
    @State private var selectedCountry: String = "default"
    @State var userLocation: String = ""
    @State var isShowing: Bool = false
    @State var descriptionFile: String = ""
    
    init(usesLocation: Bool) {
        self.usesLocation = usesLocation
        guard let dataframe = parseCSV(filename: "data") else { fatalError("Could not parse csv")}
        self.countryData = [:]
        self.countryNames = []
        dataframe.rows.forEach {row in
            if let name = row["Country"] as? String {
                countryData[name] = Country(name: name, dataRow: row)
                if name != "default" {
                    countryNames.append(name)
                }
            }
        }
        countryNames.sort()
    }
    
    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    HStack {
                        Button(action: {
                            dismiss();
                        }) {
                            Image(systemName: "chevron.left").font(.system(size: 20, weight: .medium, design: .rounded))
                        }.padding(EdgeInsets(top: 0, leading: 16, bottom: 8, trailing: 0))
                        Spacer()
                    }
                    if (!usesLocation) {
                        HStack{
                            Picker("Choose a country", selection: $selectedCountry) {
                                Text("Choose a country")
                                ForEach(countryNames, id: \.self) {
                                    Text($0).font(.system(size: 36, weight: .bold, design: .rounded))
                                }
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.gray, lineWidth: 2)
                                    .frame(minWidth: 200, minHeight: 20)
                            )
                            .padding(.bottom, 8)
                        }
                    } else {
                        Text("Current Location: " + (userLocation == "" ? "?" : userLocation))
                            .font(.system(size: 16, weight: .medium, design: .rounded)).padding(EdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12))
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.gray, lineWidth: 2)
                                    .frame(minWidth: 200, minHeight: 20)
                            ).padding(.bottom, 8).foregroundStyle(.accent)
                    }
                }
                Spacer()
                if (usesLocation) {
                    ZStack {
                        MapView(userLocation: $userLocation).opacity(userLocation != "" ? 1.0 : 0.2).disabled(userLocation == "")
                        VStack {
                            Image(systemName: "wifi.slash").font(.system(size: 40, weight: .medium, design: .rounded))
                                .foregroundStyle(.accent).padding(.bottom, 5)
                            Text("Location tracking has failed.")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                .foregroundStyle(.accent)
                                .multilineTextAlignment(.center)
                            Text("Please ensure a reliable internet connection and enable location tracking to continue.")
                                .font(.system(size: 18, weight: .medium, design: .rounded))
                                .foregroundStyle(.accent).padding(.bottom, 5)
                                .multilineTextAlignment(.center)
                            HStack {
                                Spacer()
                                Rectangle()
                                    .fill(.accent)
                                    .frame(width: 120, height: 1)
                                    .padding(.bottom, 5)
                                Text("OR")
                                    .font(.system(size: 18, weight: .medium, design: .rounded))
                                    .foregroundStyle(.accent)
                                    .padding(.bottom, 5)
                                Rectangle()
                                    .fill(.accent)
                                    .frame(width: 120, height: 1)
                                    .padding(.bottom, 5)
                                Spacer()
                            }
                            NavigationLink(destination: ContentView(usesLocation: false).navigationBarBackButtonHidden(true)) {
                                Text("Choose a country manually")
                                .foregroundStyle(.accent)
                                .font(.system(size: 22, weight: .medium, design: .rounded))
                                .padding(EdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(.accent, lineWidth: 2)
                                        .frame(minWidth: 200, minHeight: 20)
                                )
                            }
                        }
                        .opacity(userLocation == "" ? 1.0 : 0.0)
                        .padding(35)
                        .disabled(userLocation != "")
                    }
                } else {
                    ZStack{
                        Map(initialPosition:
                                .region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 90, longitude: 0.0), span: MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2))), interactionModes: []).saturation(0.0)
                        Text("Location tracking not enabled.").font(.system(size: 18, weight: .medium, design: .rounded))
                    }
                }
                Spacer()
                if let country = countryData[usesLocation ? userLocation : selectedCountry] {
                    CountryView(country: country, isShowing: $isShowing, descriptionFile: $descriptionFile).frame(height: 326).animation(.snappy(duration: 0.9), value: selectedCountry)
                } else {
                    DefaultCountryView().frame(height: 326).opacity(0.4).disabled(true)
                }
            }.padding(.bottom, 40).opacity(isShowing ? 0.2 : 1.0).disabled(isShowing)
            IndexDescription(filename: descriptionFile, isShowing: $isShowing).disabled(!isShowing)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .opacity(isShowing ? 1.0 : 0.0)
                .animation(.bouncy(duration: 0.5), value: isShowing)
                .frame(width: 250, height: 250)
        }.animation(.easeOut(duration: 0.5), value: isShowing)
    }
}
