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
            title: "",
            image: UIImage(named: "icon-home"),
            selectedImage: UIImage(named: "icon-home"))
        let listPhotosViewController = ListPhotosViewController(nibName: "ListPhotosViewController", bundle: nil)
        listPhotosViewController.tabBarItem = listPhotosItem
        let photosNavigation = createNavigation(with: listPhotosViewController)
        
        let takePhotoItem = UITabBarItem(
            title: "",
            image: UIImage(named: "icon-photo"),
            selectedImage: UIImage(named: "icon-photo"))
        let takePhotoViewController = ListPhotosViewController(nibName: "ListPhotosViewController", bundle: nil)
        takePhotoViewController.tabBarItem = takePhotoItem
        let photoNavigation = createNavigation(with: takePhotoViewController)

        self.viewControllers = [photosNavigation, photoNavigation]
        self.selectedViewController = photosNavigation
        self.selectedIndex = 0
        self.tabBar.backgroundColor = .black
        self.tabBar.barStyle = .default
        self.tabBar.tintColor = Constants.color().blue
        self.tabBar.unselectedItemTintColor = .white
    }

    private func createNavigation(with viewController: UIViewController) -> UINavigationController {
        let navigation = UINavigationController(rootViewController: viewController)
        navigation.setNavigationBarHidden(true, animated: false)

        return navigation
    }
}
