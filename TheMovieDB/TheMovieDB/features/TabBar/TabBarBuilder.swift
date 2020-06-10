//
//  TabBarBuilder.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 10/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import UIKit

struct TabBarBuilder {
    // MARK: - Public methods
    
    static func buildViewControllerAndCoordinators() -> (tabBar: TabBarController, coordinators: [Coordinator]) {
        let tabBar = TabBarController()
        let releases = LastReleasesCoordinator(navigationController: UINavigationController())
        let search = SearchCoordinator(navigationController: UINavigationController())
        let favorites = FavoritesCoordinator(navigationController: UINavigationController())
        let coordinators: [Coordinator] = [releases, search, favorites]
        var controllers: [UINavigationController] = []
        
        for (index, coordinator) in coordinators.enumerated() {
            let controller = coordinator.navigationController
            controller.tabBarItem.tag = index
            controllers.append(controller)
        }
        tabBar.viewControllers = controllers
        
        return (tabBar, coordinators)
    }
    
}
    
