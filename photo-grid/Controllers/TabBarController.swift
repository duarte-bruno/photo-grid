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
        createTabsNavigation()
        createCustomTabBar()
    }
    
    private func createTabsNavigation() {
        let listPhotosItem = UITabBarItem(title: "", image: nil, selectedImage: nil)
        let listPhotosViewController = ListPhotosViewController(nibName: "ListPhotosViewController", bundle: nil)
        listPhotosViewController.tabBarItem = listPhotosItem
        let photosNavigation = createNavigation(with: listPhotosViewController)
        
        let takePhotoItem = UITabBarItem(title: "", image: nil, selectedImage: nil)
        let takePhotoViewController = ListPhotosViewController(nibName: "ListPhotosViewController", bundle: nil)
        takePhotoViewController.tabBarItem = takePhotoItem
        let photoNavigation = createNavigation(with: takePhotoViewController)

        self.viewControllers = [photosNavigation, photoNavigation]
        self.selectedViewController = photosNavigation
        self.selectedIndex = 0
        self.tabBar.isHidden = true
    }

    private func createNavigation(with viewController: UIViewController) -> UINavigationController {
        let navigation = UINavigationController(rootViewController: viewController)
        navigation.setNavigationBarHidden(true, animated: false)

        return navigation
    }
    
    private func createCustomTabBar() {
        let tabBar = CustomTabBar()
        tabBar.delegate = self
        view.addSubview(tabBar)

        tabBar.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = tabBar.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let bottomConstraint = tabBar.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -10)
        let widthConstraint = tabBar.widthAnchor.constraint(equalToConstant: 140)
        let heightConstraint = tabBar.heightAnchor.constraint(equalToConstant: 50)
        view.addConstraints([horizontalConstraint, bottomConstraint, widthConstraint, heightConstraint])
    }
}

extension TabBarController: CustomTabBarDelegate {

    func homeSelected() {
        self.selectedIndex = 0
    }
    
    func photoSelected() {
        self.selectedIndex = 1
    }
}
