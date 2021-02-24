//
//  TabBarController.swift
//  photo-grid
//
//  Created by Bruno Duarte on 23/02/21.
//

import UIKit

class TabBarController: UITabBarController {

    // MARK: - Object lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Setup

    private func setup() {
        let listPhotosItem = UITabBarItem(
            title: "Photos",
            image: nil,
            selectedImage: nil)
        let listPhotosViewController = ListPhotosViewController(nibName: "ListPhotosViewController", bundle: nil)
        listPhotosViewController.tabBarItem = listPhotosItem
        let photosNavigation = createNavigation(with: listPhotosViewController)

        self.viewControllers = [photosNavigation]
        self.selectedViewController = photosNavigation
        self.selectedIndex = 0
    }

    private func createNavigation(with viewController: UIViewController) -> UINavigationController {
        let navigation = UINavigationController(rootViewController: viewController)
        navigation.navigationBar.prefersLargeTitles = true
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigation.navigationBar.titleTextAttributes = textAttributes
        navigation.navigationBar.largeTitleTextAttributes = textAttributes
        navigation.navigationBar.barStyle = .black
        navigation.navigationBar.tintColor = .white

        return navigation
    }
}
