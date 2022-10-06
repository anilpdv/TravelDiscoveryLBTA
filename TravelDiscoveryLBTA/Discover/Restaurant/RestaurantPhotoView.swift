//
//  RestaurantPhotoView.swift
//  TravelDiscoveryLBTA
//
//  Created by anilpdv on 06/10/22.
//
import Kingfisher
import SwiftUI

struct RestaurantPhotoView: View {
    let photos: [String]
    @State var mode = "grid"
    @State var shouldShowFullScreenModal = false
    @State var selectedPhotoIndex = 0
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                // modal
                Spacer().fullScreenCover(isPresented: $shouldShowFullScreenModal, content: {
                    ZStack(alignment: .topLeading) {
                        Color.black.ignoresSafeArea()
                        RestaurantCarouselView(imageNames: photos, selectedIndex: selectedPhotoIndex)
                        Button(action: {
                            shouldShowFullScreenModal.toggle()
                        }) {
                            Image(systemName: "xmark").font(.system(size: 32, weight: .bold)).foregroundColor(.white).padding()
                        }
                    }
                }).opacity(shouldShowFullScreenModal ? 1 : 0)
                // mode
                Picker("Test", selection: $mode) {
                    Text("Grid").tag("grid")
                    Text("List").tag("list")
                }.pickerStyle(SegmentedPickerStyle())
                    .padding()
                // Grid
                if mode == "grid" {
                    LazyVGrid(columns: [
                        GridItem(.adaptive(minimum: proxy.size.width / 3 - 6, maximum: 600), spacing: 2),
                    ], spacing: 4) {
                        ForEach(photos, id: \.self) { photo in

                            Button(action: {
                                self.selectedPhotoIndex = photos.firstIndex(of: photo) ?? 0
                                shouldShowFullScreenModal.toggle()
                            }) {
                                KFImage(URL(string: photo)!)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: proxy.size.width / 3 - 3, height: proxy.size.width / 3 - 3)
                                    .clipped()
                            }
                        }
                    }.padding(.horizontal, 2)
                } else {
                    ForEach(photos, id: \.self) { photo in
                        VStack(alignment: .leading, spacing: 4) {
                            KFImage(URL(string: photo)!)
                                .resizable()
                                .scaledToFill()
                                .cornerRadius(8)
                            HStack {
                                Image(systemName: "heart")
                                Image(systemName: "bubble.right")
                                Image(systemName: "paperplane")
                                Spacer()
                                Image(systemName: "bookmark")
                            }.padding(.horizontal, 8)
                                .font(.system(size: 18))
                            Text("lorem ispdj dfjakwjek dfjdkfjwl kdjkfdfjke fdkjkwjrkjeljs fskdfjkwej fjksdjfsk jfwkej fsdjfkdjwe fksjdksjwe jrkfjsl")
                                .font(.system(size: 14, weight: .regular))
                        }.padding()
                    }
                }

            }.navigationBarTitle("All Photots", displayMode: .inline)
        }
    }
}

struct RestaurantPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantPhotoView(photos: [])
    }
}
