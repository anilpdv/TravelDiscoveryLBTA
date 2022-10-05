//
//  DestinationHeaderView.swift
//  TravelDiscoveryLBTA
//
//  Created by anilpdv on 30/09/22.
//

import Kingfisher
import SwiftUI

struct DestinationHeaderView: UIViewControllerRepresentable {
    let imageNames: [String]

    func makeUIViewController(context: Context) -> UIViewController {
        let redVC = CustomPageViewController(imageNames: imageNames)

        return redVC
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }

    typealias UIViewControllerType = UIViewController
}

class CustomPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        allControllers.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        0
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = allControllers.firstIndex(of: viewController) else { return nil }

        if index == 0 { return nil }
        return allControllers[index - 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = allControllers.firstIndex(of: viewController) else { return nil }

        if index == allControllers.count - 1 { return nil }
        return allControllers[index + 1]
    }

    lazy var allControllers: [UIViewController] = []

    init(imageNames: [String]) {
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.systemGray5
        UIPageControl.appearance().currentPageIndicatorTintColor = .red
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)

        allControllers = imageNames.map({
            imageName in
            let hostingController = UIHostingController(rootView: KFImage(URL(string: imageName)!)
                .resizable()
                .scaledToFit()
            )
            return hostingController
        })

        if let first = allControllers.first {
            setViewControllers([first], direction: .forward, animated: true)
        }

        dataSource = self
        delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has been not implemented")
    }
}

struct DestinationHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        DestinationHeaderView(imageNames: ["eiffel_tower", "art1", "art2"])
    }
}
