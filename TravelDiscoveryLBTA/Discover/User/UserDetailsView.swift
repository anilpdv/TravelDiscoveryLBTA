//
//  UserDetailsView.swift
//  TravelDiscoveryLBTA
//
//  Created by anilpdv on 07/10/22.
//
import Kingfisher
import SwiftUI

struct UserDetails: Decodable {
    let username, lastName, firstName, profileImage: String
    let followers, following: Int
    let posts: [Post]
}

struct Post: Decodable, Hashable {
    let title, imageUrl, views: String
    let hashtags: [String]
}

class UserDetailsViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var userDetails: UserDetails?

    init(userId: Int) {
        let urlString = "https://travel.letsbuildthatapp.com/travel_discovery/user?id=\(userId)"

        guard let url = URL(string: urlString) else { return }

        DispatchQueue.main.async {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let data = data else { return }
                do {
                    self.userDetails = try JSONDecoder().decode(UserDetails.self, from: data)
                } catch let jsonError {
                    print("decoding failed for userdetails", jsonError)
                }
            }.resume()
        }
    }
}

struct UserDetailsView: View {
    @ObservedObject var vm: UserDetailsViewModel
    let user: User
    init(user: User) {
        self.user = user
        vm = .init(userId: user.id)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 12) {
                Image(user.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .padding(.horizontal)
                    .padding(.top)

                Text(user.name)
                    .font(.system(size: 14, weight: .semibold))

                HStack {
                    Text("\(vm.userDetails?.username ?? "") •")
                    Image(systemName: "hand.thumbsup.fill").font(.system(size: 14, weight: .semibold))
                    Text("2541")
                }

                Text("Youtuber, Vlogger, Travel Creator")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(Color(.lightGray))

                HStack(spacing: 12) {
                    VStack {
                        Text(String(vm.userDetails?.followers ?? 0))
                            .font(.system(size: 14, weight: .semibold))
                        Text("followers")
                            .font(.system(size: 10, weight: .regular))
                    }
                    Spacer().frame(width: 0.5, height: 12)
                        .background(Color(.lightGray))
                    VStack {
                        Text(String(vm.userDetails?.following ?? 0))
                            .font(.system(size: 14, weight: .semibold))
                        Text("following")
                            .font(.system(size: 10, weight: .regular))
                    }
                }

                HStack(spacing: 12) {
                    Button(action: {}) {
                        HStack {
                            Spacer()
                            Text("Follow")

                                .foregroundColor(.white)
                                .font(.system(size: 14, weight: .semibold))
                            Spacer()
                        }.padding(.vertical, 10)
                            .background(Color(.orange))
                            .cornerRadius(100)
                    }

                    Button(action: {}) {
                        HStack {
                            Spacer()
                            Text("Contact")
                                .foregroundColor(.black)
                                .font(.system(size: 14, weight: .semibold))
                            Spacer()
                        }.padding(.vertical, 10)
                            .background(Color(.lightGray))
                            .cornerRadius(100)
                    }
                }.padding()

                ForEach(vm.userDetails?.posts ?? [], id: \.self) { post in
                    VStack(alignment: .leading) {
                        KFImage(URL(string: post.imageUrl)!)
                            .resizable()
                            .scaledToFill()

                        HStack {
                            Image(user.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 40)
                                .clipShape(Circle())

                            VStack(alignment: .leading) {
                                Text(post.title)
                                    .font(.system(size: 14, weight: .semibold))
                                Text("\(post.views) views")
                                    .font(.system(size: 12, weight: .regular))
                                    .foregroundColor(.gray)
                            }

                        }.padding()
                        HStack {
                            ForEach(post.hashtags, id: \.self) { hashtag in
                                Text("#\(hashtag)").padding(.horizontal, 6)
                                    .padding(.vertical, 4)
                                    .background(Color(white: 0.8))
                                    .foregroundColor(.blue)
                                    .cornerRadius(20)
                                    .font(.system(size: 12, weight: .semibold))
                            }
                        }.padding(.horizontal, 18).padding(.bottom)
                    }
                    .background(Color(white: 1))
                    .cornerRadius(18)
                    .shadow(color: .init(white: 0.8), radius: 10, x: 0, y: 4).padding(.horizontal)
                }
            }

        }.navigationBarTitle(user.name, displayMode: .inline)
    }
}

struct UserDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UserDetailsView(user: .init(id: 0, name: "amy adams", imageName: "amy"))
        }
    }
}
