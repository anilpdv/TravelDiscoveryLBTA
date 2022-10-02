//
//  Destination.swift
//  TravelDiscoveryLBTA
//
//  Created by anilpdv on 25/09/22.
//

import Foundation

struct Destination: Hashable {
    let name, country, imageName: String
    let latitude, longitude: Double
}

struct Attraction: Identifiable {
    let id = UUID().uuidString
    let name: String
    let latitude, longitude: Double
}
