//
//  ActivityIndicatorView.swift
//  TravelDiscoveryLBTA
//
//  Created by anilpdv on 26/09/22.
//

import SwiftUI

struct ActivityIndicatorView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let aiv = UIActivityIndicatorView(style: .large)
        aiv.startAnimating()
        return aiv
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
    }

    typealias UIViewType = UIActivityIndicatorView
}

struct ActivityIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIndicatorView()
    }
}
