//
//  RestaurantDetails.swift
//  TravelDiscoveryLBTA
//
//  Created by anilpdv on 06/10/22.
//
import Kingfisher
import SwiftUI
struct RestaurantDetailsModel: Decodable {
    let description: String
    let popularDishes: [Dish]
    let photos: [String]
    let reviews: [Review]
}

struct Review: Decodable, Hashable {
    let user: ReviewUser
    let rating: Int
    let text: String
}

struct ReviewUser: Decodable, Hashable {
    let id: Int
    let username, firstName, lastName, profileImage: String
}

struct Dish: Decodable, Hashable {
    let name, price, photo: String
    let numPhotos: Int
}

class RestaurantDetailsViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var details: RestaurantDetailsModel?

    init() {
        let urlString = "https://travel.letsbuildthatapp.com/travel_discovery/restaurant?id=0"

        guard let url = URL(string: urlString) else { return }

        DispatchQueue.main.async {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let data = data else { return }
                self.details = try? JSONDecoder().decode(RestaurantDetailsModel.self, from: data)
            }.resume()
        }
    }
}

struct RestaurantDetails: View {
    @ObservedObject var vm = RestaurantDetailsViewModel()
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
                    NavigationLink(destination: RestaurantPhotoView(photos: vm.details?.photos ?? [])) {
                        Text("see more photos")
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .regular))
                            .frame(width: 100)
                            .multilineTextAlignment(.trailing)
                    }
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
                Text(vm.details?.description ?? "")
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
                    ForEach(vm.details?.popularDishes ?? [], id: \.self) { dish in
                        VStack(alignment: .leading) {
                            ZStack(alignment: .bottomLeading) {
                                KFImage(URL(string: dish.photo)!)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 100)
                                    .cornerRadius(5)
                                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray))
                                    .padding(.vertical, 2)
                                LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black]), startPoint: .center, endPoint: .bottom)
                                Text(dish.price)
                                    .foregroundColor(.white)
                                    .font(.system(size: 14, weight: .bold))

                            }.cornerRadius(5)

                            Text(dish.name)
                                .font(.system(size: 16, weight: .bold))
                            Text("\(dish.numPhotos) photos")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(.gray)
                        }
                    }
                }

            }.padding(.horizontal)
            HStack {
                Text("Customer Reviews")
                    .font(.system(size: 18, weight: .bold))
                Spacer()
            }.padding(.horizontal).padding(.top)

            if let reviews = vm.details?.reviews {
                ForEach(reviews, id: \.self) { review in
                    VStack(alignment: .leading) {
                        HStack {
                            KFImage(URL(string: review.user.profileImage)!)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .cornerRadius(50)

                            VStack(alignment: .leading) {
                                Text("\(review.user.firstName) \(review.user.lastName)")
                                    .font(.system(size: 18, weight: .bold))

                                HStack(spacing: 4) {
                                    ForEach(0 ..< review.rating, id: \.self) { _ in
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.orange)
                                            .font(.system(size: 12))
                                    }

                                    ForEach(0 ..< 5 - review.rating, id: \.self) { _ in
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.gray)
                                            .font(.system(size: 12))
                                    }
                                }
                            }
                            Spacer()
                            Text("12 Dec")
                                .foregroundColor(.gray)
                                .font(.system(size: 12, weight: .semibold))
                        }
                        /*@START_MENU_TOKEN@*/Text(review.text)/*@END_MENU_TOKEN@*/
                            .font(.system(size: 14, weight: .regular))
                    }.padding(.top)

                }.padding(.horizontal)
            }
        }
        .navigationBarTitle("Restaurant Details", displayMode: .inline)
    }
}

struct RestaurantDetails_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantDetails(restaurant: .init(name: "Japan's Finest Tapas", imageName: "tapas")).navigationBarTitle("Restaurant Details", displayMode: .inline)
    }
}
