//
//  CountryView.swift
//  TripSafe
//
//  Created by Gabriel Moosmann Mendez on 2024-02-22.
//

import SwiftUI

struct CountryView: View {
    var country: Country
    
    @Binding var isShowing: Bool
    @Binding var descriptionFile: String
    
    var body: some View {
        VStack {
            Spacer()
                HStack{
                    Spacer()
                    VStack {
                        Text("Police").font(.system(size: 16, weight: .medium, design: .rounded))
                        Text(country.police ?? "---")
                            .font(.system(size: (country.police ?? "---").count > 5 ? 20 : 36, weight: .thin, design: .rounded))
                            .foregroundStyle(.gray)
                            .multilineTextAlignment(.center)
                    }.frame(width: 120, height: 100).overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.gray, lineWidth: 2)
                    )
                    Spacer()
                    VStack {
                        Text("Ambulance").font(.system(size: 16, weight: .medium, design: .rounded))
                            .padding(.bottom, (country.ambulance ?? "---").count > 5 && (country.ambulance ?? "---").count <= 10 ? 4 : 0)
                        Text(country.ambulance ?? "---")
                            .font(.system(size: (country.ambulance ?? "---").count > 5 ? 20 : 36, weight: .thin, design: .rounded))
                            .foregroundStyle(.gray)
                            .padding(.bottom, (country.ambulance ?? "---").count > 5 && (country.ambulance ?? "---").count <= 10 ? 6 : 0)
                            .multilineTextAlignment(.center)
                    }.frame(width: 120, height: 100).overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.gray, lineWidth: 2)
                    )
                    Spacer()
                    VStack {
                        Text("Fire").font(.system(size: 16, weight: .medium, design: .rounded))
                        Text(country.fire ?? "---")
                            .font(.system(size: (country.fire ?? "---").count > 5 ? 20 : 36, weight: .thin, design: .rounded))
                            .foregroundStyle(.gray)
                            .multilineTextAlignment(.center)
                    }.frame(width: 120, height: 100).overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.gray, lineWidth: 2)
                    )
                    Spacer()
                }
            Spacer()
            HStack{
                Spacer()
                VStack{
                    Text("Gender-Based Violence Helpline").font(.system(size: 16))
                    Text(country.helpline ?? "This country does not have a dedicated help phone").font(.system(size: country.helpline != nil ? 26 : 14, weight: country.helpline != nil ? .thin : .medium, design: .rounded)).foregroundStyle(.gray)
                }
                .frame(width: 376, height: 60)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.gray, lineWidth: 2)
                )
                Spacer()
            }.frame(height: 60)
                
            Spacer()
            HStack {
                Spacer()
                IndexGauge(name: "GPI", min: 1, current: 6.0 - (country.GPI ?? 5.0), max: 5.0, lowToHigh: false, isShowing: $isShowing, descriptionFile: $descriptionFile)
                Spacer()
                IndexGauge(name: "WPS", min: 0, current: country.WPS ?? 0.0, max: 1.0, lowToHigh: true, isShowing: $isShowing, descriptionFile: $descriptionFile)
                Spacer()
            }.padding(.bottom, 10)
            Spacer()
        }
    }
}



