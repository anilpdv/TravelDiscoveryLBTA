//
//  PopularDestinationsView.swift
//  TravelDiscoveryLBTA
//
//  Created by anilpdv on 25/09/22.
//

import MapKit
import SwiftUI

struct PopularDestinationsView: View {
    let destinations: [Destination] = [
        .init(name: "Paris", country: "France", imageName: "eiffel_tower", latitude: 48.859565, longitude: 2.353235),
        .init(name: "Tokyo", country: "Japan", imageName: "japan", latitude: 35.67988, longitude: 139.7695),
        .init(name: "New York", country: "US", imageName: "new_york", latitude: 40.71592, longitude: -74.005),
    ]
    fileprivate func popularDestinationTile(_ destination: Destination) -> some View {
        return VStack(alignment: .leading, spacing: 0) {
            Image(destination.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .cornerRadius(6)
                .padding(.horizontal, 6)
                .padding(.vertical, 6)

            Text(destination.name)
                .font(.system(size: 14, weight: .semibold))
                .padding(.horizontal)

            Text(destination.country)
                .font(.system(size: 14, weight: .semibold))
                .padding(.horizontal)
                .padding(.bottom, 8)
                .foregroundColor(.gray)
        }
        .asTile()
    }

    var body: some View {
        VStack {
            HStack {
                Text("Popular Destinations")
                    .font(.system(size: 14, weight: .semibold))
                Spacer()
                Text("See all")
                    .font(.system(size: 14, weight: .semibold))
            }.padding(.horizontal).padding(.top)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(destinations, id: \.self) { destination in
                        NavigationLink(destination: PopularDestinationDetailsView(destination: destination), label: {
                            popularDestinationTile(destination)
                                .padding(.bottom)
                        })
                    }
                }.padding(.horizontal)
            }
        }
    }
}

struct DestinationDetails: Decodable {
    let description: String
    let photos: [String]
}

class DestinationDetailsViewModel: ObservableObject {
    @Published var loading = false
    @Published var destinationDetails: DestinationDetails?

    init(name: String) {
        let urlString = "https://travel.letsbuildthatapp.com/travel_discovery/destination?name=\(name.lowercased())".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""

        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            DispatchQueue.main.async {
                guard let data = data else { return }
                print(String(data: data, encoding: .utf8) as Any)

                do {
                    self.destinationDetails = try JSONDecoder().decode(DestinationDetails.self, from: data)
                } catch {
                    print("Failed to decode JSON", error)
                }
            }

        }.resume()
    }
}

struct PopularDestinationDetailsView: View {
    @ObservedObject var vm: DestinationDetailsViewModel
    let destination: Destination
    let attractions: [Attraction] = [
        .init(name: "Effiel Tower", latitude: 48.859565, longitude: 2.353235),
    ]
    @State var region: MKCoordinateRegion
    @State var isShowingAttractions = false

    init(destination: Destination) {
        self.destination = destination
        region = MKCoordinateRegion(center: .init(latitude: destination.latitude, longitude: destination.longitude), span: .init(latitudeDelta: 0.3, longitudeDelta: 0.3))
        vm = .init(name: destination.name)
    }

    var body: some View {
        ScrollView {
            if let photos = vm.destinationDetails?.photos {
                DestinationHeaderView(imageNames: photos)
                    .scaledToFit()
            }

            VStack(alignment: .leading) {
                Text(destination.name)
                    .font(.system(size: 20, weight: .bold))

                Text(destination.country)

                HStack {
                    ForEach(0 ..< 5, id: \.self) { _ in
                        Image(systemName: "star.fill")
                            .foregroundColor(.orange)
                    }
                }
                .padding(.top, 2)
                .padding(.bottom, 2)

                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
                HStack {
                    Spacer()
                }
            }.padding()

            HStack {
                Text("Location")
                    .font(.system(size: 18, weight: .semibold))
                Spacer()
                Button(action: {
                    isShowingAttractions.toggle()
                }, label: {
                    Text("\(isShowingAttractions ? "Hide" : "Show") Annotations")
                        .font(.system(size: 16, weight: .semibold))

                })

                Toggle("", isOn: $isShowingAttractions)
                    .labelsHidden()
            }.padding(.horizontal)

            Map(coordinateRegion: $region, annotationItems: isShowingAttractions ? attractions : []) { attraction in
                MapMarker(coordinate: .init(latitude: attraction.latitude, longitude: attraction.longitude), tint: .red)
            }
            .scaledToFit()

        }.navigationBarTitle(destination.name, displayMode: .inline)
    }
}

struct PopularDestinationsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView(content: {
            PopularDestinationDetailsView(destination: .init(name: "Paris", country: "France", imageName: "eiffel_tower", latitude: 0, longitude: 0))
        })
        PopularDestinationsView()
    }
}
