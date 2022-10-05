//
//  PopularRestaurantsView.swift
//  TravelDiscoveryLBTA
//
//  Created by anilpdv on 25/09/22.
//

import SwiftUI

struct PopularRestaurantsView: View {
    let restaurants: [Restaurant] = [
        .init(name: "Japan's Finest Tapas", imageName: "tapas"),
        .init(name: "Bar & Gril", imageName: "bar_grill"),
    ]
    var body: some View {
        VStack {
            HStack {
                Text("Popular Places to eat")
                    .font(.system(size: 14, weight: .semibold))
                Spacer()
                Text("See all")
                    .font(.system(size: 14, weight: .semibold))
            }.padding(.horizontal).padding(.top)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(restaurants, id: \.self) { restaurant in
                        NavigationLink(destination: RestaurantDetails(restaurant: restaurant)) {
                            RestaurantTile(restaurant: restaurant)
                                .padding(.bottom)
                                .foregroundColor(Color(.label))
                        }
                    }
                }.padding(.horizontal)
            }
        }
    }
}

struct PopularRestaurantsView_Previews: PreviewProvider {
    static var previews: some View {
        PopularRestaurantsView()
    }
}
