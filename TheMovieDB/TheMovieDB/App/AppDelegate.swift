//
//  AppDelegate.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 08/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        coordinator = AppCoordinator(window: window!)
        coordinator?.start()
        
        return true
    }
}

