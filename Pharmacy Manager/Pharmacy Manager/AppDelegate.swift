//
//  AppDelegate.swift
//  Pharmacy Manager
//
//  Created by Mikhail Timoscenko on 09.09.2020.
//  Copyright © 2020 PharmacyManager. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private var appNavigationCoordinator: AppNavigation!


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        CoreDataService.shared.setup()
        
        window = UIWindow(frame: UIScreen.main.bounds)

        appNavigationCoordinator = AppNavigation(window: window!)
        appNavigationCoordinator.startFlow()

        return true
    }
}

