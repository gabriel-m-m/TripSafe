//
//  IndexDescription.swift
//  TripSafe
//
//  Created by Gabriel Moosmann Mendez on 2024-03-30.
//

import SwiftUI

struct IndexDescription: View {
    var filename: String
    @Binding var isShowing: Bool
    
    var body: some View {
        ZStack {
            let description: String = getString(path: filename)
            VStack {
                ZStack {
                    Text("What is the " + filename + "?").font(.system(size: 16, weight: .medium, design: .rounded))
                        .padding(.top, 14)
                        .foregroundStyle(.accent)
                    HStack{
                        Spacer()
                        Button(action: {isShowing = false}) {
                            Image(systemName: "xmark").font(.system(size: 16, weight: .medium, design: .rounded))
                        }.padding(EdgeInsets(top: 14, leading: 14, bottom: 0, trailing: 14))
                    }
                }
                Rectangle()
                    .fill(.accent)
                    .frame(width: 200, height: 1)
                Text(description)
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .padding(EdgeInsets(top: 6, leading: 14, bottom: 0, trailing: 14))
                Spacer()
            }
             
        }
        .background(Color(UIColor.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .frame(width: 270, height: 302)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.gray, lineWidth: 2))
    }
}


// REQUIRES: path - the path to the .txt file containing the index description
// EFFECTS: If succesful, returns the contents of the .txt file, otherwise returns a failure message
private func getString(path: String) -> String {
    if let path = Bundle.main.path(forResource: path, ofType: "txt") {
        do {
            let contents = try String(contentsOfFile: path)
            return contents
        } catch {
            return (error.localizedDescription)
        }
    } else {
        return "failed"
    }
}
