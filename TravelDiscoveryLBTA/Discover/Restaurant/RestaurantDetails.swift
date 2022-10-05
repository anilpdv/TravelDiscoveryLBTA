//
//  RestaurantDetails.swift
//  TravelDiscoveryLBTA
//
//  Created by anilpdv on 06/10/22.
//

import SwiftUI

struct RestaurantDetails: View {
    let restaurant: Restaurant
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomLeading) {
                Image(restaurant.imageName)
                    .resizable()
                    .scaledToFit()

                LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black]), startPoint: .center, endPoint: .bottom)

                HStack {
                    VStack(alignment: .leading) {
                        Text(restaurant.name)
                            .foregroundColor(.white)
                            .font(.system(size: 22, weight: .bold))
                            .padding(.bottom, 6)

                        HStack {
                            ForEach(0 ..< 5, id: \.self) { _ in
                                Image(systemName: "star.fill")
                                    .foregroundColor(.orange)
                            }
                        }
                    }.padding()

                    Spacer()

                    Text("see more photos")
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .regular))
                        .frame(width: 100)
                        .multilineTextAlignment(.trailing)
                }
            }

            VStack(alignment: .leading) {
                Text("Location & Description")
                    .font(.system(size: 18, weight: .bold))
                Text("Tokyo, Japan")
                    .padding(.top, 10)
                HStack {
                    ForEach(0 ..< 5, id: \.self) { _ in
                        Image(systemName: "dollarsign.circle.fill")
                            .foregroundColor(.orange)
                    }
                }.padding(.top, 0.1)
                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type")
                    .font(.system(size: 16, weight: .regular))
                    .padding(.top)
            }.padding()

            HStack {
                Text("Popular Dishes")
                    .font(.system(size: 18, weight: .bold))
                Spacer()
            }.padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0 ..< 5, id: \.self) { _ in
                        VStack(alignment: .leading) {
                            Image("tapas")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 100)
                                .cornerRadius(5)
                                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray))
                                .padding(.vertical, 2)
                            Text("Japanese")
                                .font(.system(size: 16, weight: .bold))
                            Text("88 photos")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(.gray)
                        }
                    }
                }
            }.padding(.horizontal)
        }
        .navigationBarTitle("Restaurant Details", displayMode: .inline)
    }
}

struct RestaurantDetails_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantDetails(restaurant: .init(name: "Japan's Finest Tapas", imageName: "tapas")).navigationBarTitle("Restaurant Details", displayMode: .inline)
    }
}
