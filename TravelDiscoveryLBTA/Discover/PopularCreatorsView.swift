//
//  PopularCreatorsView.swift
//  TravelDiscoveryLBTA
//
//  Created by anilpdv on 25/09/22.
//

import SwiftUI

struct PopularCreatorsView: View {
    let users: [User] = [
        .init(name: "Amy Adams", imageName: "amy"),
        .init(name: "Billy harold", imageName: "billy"),
        .init(name: "Sam Smith", imageName: "sam"),
    ]
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Trending Creators")
                    .font(.system(size: 14, weight: .semibold))
                Spacer()
                Text("See all")
                    .font(.system(size: 14, weight: .semibold))
            }.padding(.horizontal).padding(.top)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 12) {
                    ForEach(users, id: \.self) { user in
                        VStack {
                            Image(user.imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 60, height: 60)
                                .cornerRadius(60)

                            Text(user.name)
                                .font(.system(size: 11, weight: .semibold))
                                .multilineTextAlignment(.center)
                        }
                        .frame(width: 60)
                        .shadow(color: .gray, radius: 2, x: 1.0, y: 2)
                        .padding(.bottom)
                    }
                }.padding(.horizontal)
            }
        }
    }
}

struct PopularCreatorsView_Previews: PreviewProvider {
    static var previews: some View {
        PopularCreatorsView()
    }
}
