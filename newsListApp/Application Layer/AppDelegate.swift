//
//  AppDelegate.swift
//  newsListApp
//
//  Created by Aiymgul Srasenbayeva on 1/29/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let navController = UINavigationController(rootViewController: MainPage())
        self.window?.rootViewController = navController
        window?.makeKeyAndVisible()
        return true
    }
}

