//
//  ContentView.swift
//  TravelDiscoveryLBTA
//
//  Created by anilpdv on 24/09/22.
//

import SwiftUI

extension Color {
    static let defaultBackground = Color("defaultBackground")
    static let tileBackground = Color("tileBackground")
}

struct DisoverView: View {
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.white,
        ]
    }

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(.orange), Color(.systemOrange)]), startPoint: .top, endPoint: .center)
                    .ignoresSafeArea()

                Color(.init(white: 0.95, alpha: 1)).offset(y: 400)

                ScrollView {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        Text("where to you want to go?")
                        Spacer()
                    }.font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.4)))
                        .cornerRadius(13)
                        .padding(16)

                    DiscoverCategories()

                    VStack {
                        PopularDestinationsView()
                        PopularRestaurantsView()
                        PopularCreatorsView()
                    }
                    .background(Color.defaultBackground)
                    .cornerRadius(18)
                    .padding(.top, 32)
                }
            }
            .navigationTitle("Discover")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DisoverView().colorScheme(.dark)
    }
}
