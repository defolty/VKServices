//
//  AppDelegate.swift
//  VKChallenge
//
//  Created by Nikita Nesporov on 13.07.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let tableViewController = MainTableViewController()
        let navController = UINavigationController(rootViewController: tableViewController)
        UINavigationBar.appearance().barTintColor = UIColor(red: 55.0/255.0, green: 55.0/255.0, blue: 55.0/255.0, alpha: 1.0)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        window.rootViewController = navController
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }
}

