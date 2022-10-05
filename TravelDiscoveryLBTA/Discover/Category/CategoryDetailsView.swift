//
//  CategoryDetailsView.swift
//  TravelDiscoveryLBTA
//
//  Created by anilpdv on 26/09/22.
//

import Kingfisher
import SwiftUI

// view model
class CategoryDetailsViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var errorMessage = ""
    @Published var places = [Place]()

    init(name: String) {
        let urlString = "https://travel.letsbuildthatapp.com/travel_discovery/category?name=\(name.lowercased())".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, resp, error in
            if let statusCode = (resp as? HTTPURLResponse)?.statusCode, statusCode >= 400 {
                self.isLoading = false
                self.errorMessage = "Error Message: \(statusCode)"
                return
            }
            guard let data = data else { return }

            do {
                self.places = try JSONDecoder().decode([Place].self, from: data)

            } catch {
                print("Failed to decode json", error)
            }
            self.isLoading = false
        }.resume()
    }
}

struct CategoryDetailsView: View {
    private let name: String

    @ObservedObject var vm: CategoryDetailsViewModel

    init(name: String) {
        self.name = name
        vm = .init(name: name)
    }

    var body: some View {
        ZStack {
            if vm.isLoading {
                ActivityIndicatorView()
            } else {
                ZStack {
                    if !vm.errorMessage.isEmpty {
                        VStack {
                            Image(systemName: "x.circle.fill")
                                .foregroundColor(.red)
                                .font(.system(size: 50, weight: .bold))
                                .padding()
                            Text(vm.errorMessage)
                                .font(.system(size: 12, weight: .bold))
                        }
                    } else {
                        ScrollView {
                            ForEach(vm.places, id: \.self) { category in
                                VStack(alignment: .leading, spacing: 8) {
                                    KFImage(URL(string: category.thumbnail)!)
                                        .resizable()
                                        .scaledToFill()
                                    Text(category.name)
                                        .font(.system(size: 12, weight: .bold))
                                        .padding()
                                }
                                .asTile()
                                .padding()
                            }
                        }
                    }
                }
            }
        }
        .navigationBarTitle(name, displayMode: .inline)
    }
}

struct CategoryDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CategoryDetailsView(name: "Live Events")
        }
    }
}
