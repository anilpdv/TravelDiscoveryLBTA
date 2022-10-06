//
//  RestaurantPhotoView.swift
//  TravelDiscoveryLBTA
//
//  Created by anilpdv on 06/10/22.
//

import SwiftUI

struct RestaurantPhotoView: View {
    @State var mode = "grid"
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                // mode
                Picker("Test", selection: $mode) {
                    Text("Grid").tag("grid")
                    Text("List").tag("list")
                }.pickerStyle(SegmentedPickerStyle())
                    .padding()
                // Grid
                if(mode == "grid") {
                    LazyVGrid(columns: [
                        GridItem(.adaptive(minimum: proxy.size.width / 3 - 6, maximum: 600), spacing: 2),
                    ], spacing: 4) {
                        ForEach(0 ..< 70, id: \.self) { _ in
                            Image("tapas")
                                .resizable()
                                .scaledToFill()
                                .frame(width: proxy.size.width / 3 - 3, height: proxy.size.width / 3 - 3)
                                .clipped()
                        }
                    }.padding(.horizontal, 2)
                } else {
                    Text("list")
                }
               

            }.navigationBarTitle("All Photots", displayMode: .inline)
        }
    }
}

struct RestaurantPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantPhotoView()
    }
}
