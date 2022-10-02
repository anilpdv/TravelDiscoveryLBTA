//
//  DestinationHeaderView.swift
//  TravelDiscoveryLBTA
//
//  Created by anilpdv on 30/09/22.
//

import SwiftUI

struct DestinationHeaderView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let redVC = UIViewController()
        redVC.view.backgroundColor = .green
        return redVC
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }

    typealias UIViewControllerType = UIViewController
}

struct DestinationHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        DestinationHeaderView()
    }
}
