//
//  TabBarCoordinator.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 10/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import UIKit

// MARK: - Class

class TabBarCoordinator: NSObject, Coordinator {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let tabBarController = TabBarController()
        tabBarController.coordinator = self
        
        let releasesNavigationController = UINavigationController()
        releasesNavigationController.navigationBar.barTintColor = UIColor.black
        releasesNavigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(named: "gold") ?? .white]
        releasesNavigationController.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "gold") ?? .white]
        releasesNavigationController.navigationBar.isTranslucent = false
        releasesNavigationController.navigationBar.prefersLargeTitles = true
        releasesNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .mostRecent, tag: 0)
        let releasesCoordinator = LastReleasesCoordinator(navigationController: releasesNavigationController)
        
        let searchNavigationController = UINavigationController()
        searchNavigationController.navigationBar.prefersLargeTitles = true
        searchNavigationController.navigationBar.isTranslucent = false
        searchNavigationController.navigationBar.barTintColor = UIColor.black
        searchNavigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(named: "gold") ?? .white]
        searchNavigationController.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "gold") ?? .white]
        searchNavigationController.tabBarItem = UITabBarItem(
            tabBarSystemItem: .search, tag: 1)
        let searchCoordinator = SearchCoordinator(navigationController: searchNavigationController)
        
        let favoritesNavigationController = UINavigationController()
        favoritesNavigationController.tabBarItem = UITabBarItem(
            tabBarSystemItem: .favorites, tag: 2)
        favoritesNavigationController.navigationBar.prefersLargeTitles = true
        favoritesNavigationController.navigationBar.isTranslucent = false
        favoritesNavigationController.navigationBar.barTintColor = UIColor.black
        favoritesNavigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(named: "gold") ?? .white]
        favoritesNavigationController.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "gold") ?? .white]
        
        let favoritesCoordinator = FavoritesCoordinator(navigationController: favoritesNavigationController)
        
        tabBarController.viewControllers = [releasesNavigationController,
                                            searchNavigationController,
                                            favoritesNavigationController]
        
        tabBarController.modalPresentationStyle = .fullScreen
        
        navigationController.present(tabBarController, animated: true, completion: nil)
        coordinate(to: releasesCoordinator)
        coordinate(to: searchCoordinator)
        coordinate(to: favoritesCoordinator)
    }
    
}


