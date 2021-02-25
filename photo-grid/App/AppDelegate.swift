//
//  AppDelegate.swift
//  photo-grid
//
//  Created by Bruno Duarte on 23/02/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let navigation = UINavigationController(rootViewController: InitialViewController())
        navigation.setNavigationBarHidden(true, animated: false)
        
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()

        return true
    }
}

