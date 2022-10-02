//
//  TileModifier.swift
//  TravelDiscoveryLBTA
//
//  Created by anilpdv on 25/09/22.
//

import SwiftUI

extension View {
    func asTile() -> some View {
        modifier(TileModifier())
    }
}

struct TileModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color(.init(white: 1, alpha: 1)))
            .cornerRadius(8)
            .shadow(color: .init(.sRGB, white: 0.8, opacity: 1), radius: 4, x: 0.0, y: 2)
    }
}
