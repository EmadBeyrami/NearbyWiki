//
//  AppDelegate.swift
//  LocationBased Wikipedia
//
//  Created by Emad Bayramy on 7/31/21.
//

import UIKit
import GoogleMaps

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        LanguageManager.shared.currentLanguage = .english
        setupGoogle()
        setupCoordinator()
        return true
    }
    
    fileprivate func setupCoordinator() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navController = CustomNavigationController()

        appCoordinator = AppCoordinator(navigationController: navController, window: window)
        appCoordinator.start()
    }

}

extension AppDelegate {
    
    fileprivate func setupGoogle() {
        GMSServices.provideAPIKey(DataManager.shared.googleMapAccessToken)
    }
    
}
