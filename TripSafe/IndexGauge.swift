//
//  IndexGauge.swift
//  TripSafe
//
//  Created by Gabriel Moosmann Mendez on 2024-02-18.
//

import Foundation
import SwiftUI

struct IndexGauge: View {
    let gradient = Gradient(colors: [.red, .yellow, .green])
    var name: String
    var min: Double
    var current: Double
    var max: Double
    var lowToHigh: Bool
    @Binding var isShowing: Bool
    @Binding var descriptionFile: String
    
    var body: some View {
        VStack{
            HStack {
                Text(name).font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundStyle(.blue).padding(8)
                Spacer(minLength: 10)
                Button(action: {descriptionFile = name; DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                    isShowing = true
                }}) {
                    Image(systemName: "questionmark.circle").font(.system(size: 20, weight: .medium, design: .rounded))
                }
                .scaleEffect(CGSize(width: 1.2, height: 1.2))
            }.padding(EdgeInsets(top: 0, leading: 5, bottom: 10, trailing: 10))
            Gauge(value: current, in: min...max) {
            } currentValueLabel: {
                if current != min {
                    Text(lowToHigh ? "\(String(format: "%.3f", current))" : "\(String(format: "%.3f", (max + min) - current))")
                        .foregroundColor(getColor(min:min, curr: current, max: max)).font(.system(size: 14, weight: .medium, design: .rounded)).saturation(1.5)
                } else {
                    Text("N/A")
                        .foregroundColor(Color(UIColor.label)).opacity(0.7).font(.system(size: 12, weight: .medium, design: .rounded))
                }
            } minimumValueLabel: {
                Text(lowToHigh ? "\(Int(min))" : "\(Int(max))")
                    .foregroundColor(Color.red)
            } maximumValueLabel: {
                Text(lowToHigh ? "\(Int(max))" : "\(Int(min))")
                    .foregroundColor(Color.green)
            }
            .gaugeStyle(.accessoryCircular)
            .tint(gradient)
            .scaleEffect(CGSize(width: 2.0, height: 2.0)) 
        }
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.gray, lineWidth: 2)
                .padding(.bottom, -50)
        )
    }
    
    
    // REQUIRES: min - the minimum value of the gauge
    //           curr - the current value of the gauge
    //           max - the maximum value of the gauge
    //           min <= curr <= max
    // EFFECTS: Returns a Color instance for curr based on proximity to max and min
    func getColor(min: Double, curr: Double, max: Double) -> Color {
        let percentage: Double = (curr - min) / (max - min)
        var red: Double = 0
        var green: Double = 0
        var blue: Double = 0
        if (percentage > 0.5) {
            let factor: Double = ((percentage - 0.5) * 2.0)
            red = 247.0 + (101 - 247.0) * factor
            green = 207.0 + (196 - 207.0) * factor
            blue = 70.0 + (103 - 70.0) * factor
        } else {
            let factor: Double = (percentage * 2.0)
            red = 235 + (247.0 - 235) * factor
            green = 78 + (207.0 - 78) * factor
            blue = 62 + (70.0 - 62) * factor
        }
        red = red / 256.0
        green = green / 256.0
        blue = blue / 256.0
        return Color(red: red, green: green, blue: blue)
    }
}
