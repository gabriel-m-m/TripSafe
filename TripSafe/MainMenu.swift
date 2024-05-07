//
//  MainMenu.swift
//  TripSafe
//
//  Created by Gabriel Moosmann Mendez on 2024-03-30.
//

import SwiftUI

struct MainMenu: View {
    
    var body: some View {
            NavigationStack {
                Image(uiImage: UIImage(named: "AppLogo") ?? UIImage()).frame(width: 150, height: 150)
                    .scaleEffect(CGSize(width: 0.2, height: 0.2))
                    .background(Color(UIColor.systemBackground))
                
                Text("TripSafe").font(.system(size: 30, weight: .bold, design: .rounded)).foregroundStyle(.accent)
                    .padding(.bottom, 4)
                
                Text("Your Travel Companion").font(.system(size: 20, weight: .medium, design: .rounded)).foregroundStyle(.accent)
                Spacer().frame(minHeight: 100, maxHeight: 100)
                NavigationLink(destination: ContentView(usesLocation: true).navigationBarBackButtonHidden(true)) {
                    HStack {
                        Text("Use My Location")
                        Image(systemName: "location")
                    }.font(.system(size: 22, weight: .medium, design: .rounded))
                }.padding(.bottom, 5)
                HStack {
                    Spacer()
                    Rectangle()
                        .fill(.accent)
                        .frame(width: 120, height: 1)
                        .padding(.bottom, 5)
                    Text("OR").font(.system(size: 18, weight: .medium, design: .rounded)).foregroundStyle(.accent).padding(.bottom, 5)
                    Rectangle()
                        .fill(.accent)
                        .frame(width: 120, height: 1)
                        .padding(.bottom, 5)
                    Spacer()
                }
                NavigationLink(destination: ContentView(usesLocation: false).navigationBarBackButtonHidden(true)) {
                    HStack {
                        Text("Choose Manually")
                        Image(systemName: "hand.point.up.left")
                    }.font(.system(size: 22, weight: .medium, design: .rounded))
                }
            }
    }
}

struct Disclaimer: View {
    
    var body: some View {
        NavigationStack {
            Spacer()
            Text("Disclaimer")
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .foregroundStyle(.accent)
                .padding(.bottom, 10)
            Text("All travel safety data was compiled as of January 2024. Changes in safety conditions, regulations, or other factors may occur after this date, and therefore, the current accuracy of the data cannot be guaranteed. The developers and providers of this app shall not be held liable for any damages, losses, or injuries resulting from the use or misuse of the app, or reliance on its content.")
                .font(.system(size: 16, weight: .thin, design: .rounded))
                .foregroundStyle(.accent)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20))
                .multilineTextAlignment(.center)
            NavigationLink(destination: MainMenu().navigationBarBackButtonHidden(true)) {
                Text("I understand")
            }
            .font(.system(size: 20, weight: .medium, design: .rounded))
            .foregroundStyle(Color(UIColor.systemBackground))
            .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
            .background(.accent)
            .cornerRadius(20)
            Spacer()
        }
    }
}
