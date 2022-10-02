//
//  DiscoverCategories.swift
//  TravelDiscoveryLBTA
//
//  Created by anilpdv on 25/09/22.
//

import SwiftUI

struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }

    var body: Content {
        build()
    }
}

struct DiscoverCategories: View {
    let categories: [Category] = [
        .init(name: "Art", imageName: "paintpalette.fill"),
        .init(name: "Sports", imageName: "sportscourt.fill"),
        .init(name: "Live Events", imageName: "music.mic.circle.fill"),
        .init(name: "Food", imageName: "takeoutbag.and.cup.and.straw.fill"),
        .init(name: "History", imageName: "book.closed.fill"),
    ]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 16) {
                ForEach(categories, id: \.self) { category in
                    NavigationLink(destination: NavigationLazyView(CategoryDetailsView(name: category.name)), label: {
                        VStack(spacing: 5) {
                            Image(systemName: category.imageName)
                                .font(.system(size: 24))
                                .foregroundColor(.orange)
                                .frame(width: 60, height: 60)
                                .background(Color.white)
                                .cornerRadius(68)

                            Text(category.name)
                                .font(.system(size: 12, weight: .bold))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)

                        }.frame(width: 65)
                    })
                }
            }.padding(.horizontal)
        }
    }
}

struct DiscoverCategories_Previews: PreviewProvider {
    static var previews: some View {
        DisoverView()
    }
}
