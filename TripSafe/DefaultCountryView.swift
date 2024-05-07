//
//  CountryView.swift
//  TripSafe
//
//  Created by Gabriel Moosmann Mendez on 2024-02-22.
//

import Foundation
import SwiftUI

struct DefaultCountryView: View {
    
    var body: some View {
        VStack {
            Spacer()
                HStack{
                    Spacer()
                    VStack {
                        Text("Police").font(.system(size: 16, weight: .medium, design: .rounded))
                        Text("---").font(.system(size: 36, weight: .thin, design: .rounded))
                            .foregroundStyle(.gray)
                    }.frame(width: 120, height: 100).overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.gray, lineWidth: 2)
                    )
                    Spacer()
                    VStack {
                        Text("Ambulance").font(.system(size: 16, weight: .medium, design: .rounded))
                        Text("---").font(.system(size: 36, weight: .thin, design: .rounded))
                            .foregroundStyle(.gray)
                    }.frame(width: 120, height: 100).overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.gray, lineWidth: 2)
                    )
                    Spacer()
                    VStack {
                        Text("Fire").font(.system(size: 16, weight: .medium, design: .rounded))
                        Text("---").font(.system(size: 36, weight: .thin, design: .rounded))
                            .foregroundStyle(.gray)
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
                    Text("---").font(.system(size: 26, weight: .thin, design: .rounded)).foregroundStyle(.gray)
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
                IndexGauge(name: "GPI", min: 1, current: 1.0, max: 5.0, lowToHigh: false, isShowing: .constant(false), descriptionFile: .constant("NONE"))
                Spacer()
                IndexGauge(name: "WPS", min: 0, current: 0.0, max: 1.0, lowToHigh: true, isShowing: .constant(false), descriptionFile: .constant("NONE"))
                Spacer()
            }.padding(.bottom, 10)
            Spacer()
        }
    }
}
