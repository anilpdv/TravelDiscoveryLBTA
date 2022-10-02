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
                        HStack(spacing: 8) {
                            Image(restaurant.imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 60, height: 60)
                                .clipped()
                                .cornerRadius(8)
                                .padding(.leading, 6)
                                .padding(.vertical, 6)

                            VStack(alignment: .leading, spacing: 6) {
                                HStack {
                                    Text(restaurant.name)
                                    Spacer()
                                    Button(action: {}, label: {
                                        Image(systemName: "ellipsis")
                                    }).foregroundColor(.gray)
                                }

                                HStack {
                                    Image(systemName: "star.fill")
                                    Text("4.7 • Sushi • $$")
                                }

                                Text("Japan's Finest Tapas")
                            }
                            .font(.system(size: 14, weight: .semibold))
                            Spacer()
                        }
                        .frame(width: 300)
                        .asTile()
                        .padding(.bottom)
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
