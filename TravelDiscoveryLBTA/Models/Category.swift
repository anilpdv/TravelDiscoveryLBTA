//
//  Category.swift
//  TravelDiscoveryLBTA
//
//  Created by anilpdv on 25/09/22.
//

import Foundation

struct Category: Hashable {
    let name, imageName: String
}

struct Place: Decodable, Hashable {
    let name, thumbnail: String
}
