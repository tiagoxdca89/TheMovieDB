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
    
    // MARK: - Public Properties
    
    let navigationController: UINavigationController
    
    // MARK: - Initialization
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    //MARK: - Public methods
    
    func start() {
        let tabBarController = TabBarController()
        tabBarController.coordinator = self
        
        let releasesNavigation = setupNavigationController(item: .mostRecent, tag: 0)
        let releasesCoordinator = LastReleasesCoordinator(navigationController: releasesNavigation)
        
        let searchNavigation = setupNavigationController(item: .search, tag: 1)
        let searchCoordinator = SearchCoordinator(navigationController: searchNavigation)
        
        let favoritesNavigation = setupNavigationController(item: .favorites, tag: 2)
        let favoritesCoordinator = FavoritesCoordinator(navigationController: favoritesNavigation)
        
        tabBarController.viewControllers = [releasesNavigation,
                                            searchNavigation,
                                            favoritesNavigation]
        tabBarController.modalPresentationStyle = .fullScreen
        
        navigationController.present(tabBarController, animated: true, completion: nil)
        coordinate(to: releasesCoordinator)
        coordinate(to: searchCoordinator)
        coordinate(to: favoritesCoordinator)
    }
    
    //MARK: - Private methods
    
    private func setupNavigationController(item: UITabBarItem.SystemItem, tag: Int) -> UINavigationController {
            let navigationController = UINavigationController()
            navigationController.navigationBar.barTintColor = UIColor.black
            navigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(named: "gold") ?? .white]
            navigationController.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "gold") ?? .white]
            navigationController.navigationBar.isTranslucent = false
            navigationController.navigationBar.prefersLargeTitles = true
            navigationController.tabBarItem = UITabBarItem(tabBarSystemItem: item, tag: tag)
            return navigationController
        }
}
