//
//  RestaurantTile.swift
//  TravelDiscoveryLBTA
//
//  Created by anilpdv on 06/10/22.
//

import SwiftUI

struct RestaurantTile: View {
    let restaurant: Restaurant

    var body: some View {
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
    }
}

struct RestaurantTile_Previews: PreviewProvider {
    static let restaurant: Restaurant = .init(name: "Japan's Finest Tapas", imageName: "tapas")
    static var previews: some View {
        RestaurantTile(restaurant: restaurant)
    }
}
