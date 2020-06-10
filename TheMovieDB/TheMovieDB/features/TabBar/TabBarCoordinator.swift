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
        releasesNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .mostRecent, tag: 0)
        let releasesCoordinator = LastReleasesCoordinator(navigationController: releasesNavigationController)
        
        let searchNavigationController = UINavigationController()
        searchNavigationController.tabBarItem = UITabBarItem(
            tabBarSystemItem: .search, tag: 1)
        let searchCoordinator = SearchCoordinator(navigationController: searchNavigationController)
        
        let favoritesNavigationController = UINavigationController()
        favoritesNavigationController.tabBarItem = UITabBarItem(
            tabBarSystemItem: .favorites, tag: 2)
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

