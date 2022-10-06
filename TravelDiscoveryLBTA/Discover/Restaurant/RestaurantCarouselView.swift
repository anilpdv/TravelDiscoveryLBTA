//
//  RestaurantCarouselView.swift
//  TravelDiscoveryLBTA
//
//  Created by anilpdv on 07/10/22.
//

import Kingfisher
import SwiftUI

struct RestaurantCarouselView: UIViewControllerRepresentable {
    let imageNames: [String]
    let selectedIndex: Int

    func makeUIViewController(context: Context) -> UIViewController {
        let redVC = RestuarantCarouselPageViewController(imageNames: imageNames, selectedIndex: selectedIndex)

        return redVC
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }

    typealias UIViewControllerType = UIViewController
}

class RestuarantCarouselPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        allControllers.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        selectedIndex
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
    var selectedIndex: Int
    init(imageNames: [String], selectedIndex: Int) {
        self.selectedIndex = selectedIndex
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.systemGray5
        UIPageControl.appearance().currentPageIndicatorTintColor = .red
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)

        allControllers = imageNames.map({
            imageName in
            let hostingController = UIHostingController(rootView: ZStack {
                Color.black
                KFImage(URL(string: imageName)!)
                    .resizable()
                    .scaledToFit()
            }
            )
            return hostingController
        })

        if selectedIndex < allControllers.count {
            setViewControllers([allControllers[selectedIndex]], direction: .forward, animated: true)
        }

        dataSource = self
        delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has been not implemented")
    }
}

struct RestaurantCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantCarouselView(imageNames: [], selectedIndex: 5)
    }
}
