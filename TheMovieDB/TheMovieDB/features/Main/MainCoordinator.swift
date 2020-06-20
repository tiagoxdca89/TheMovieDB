//
//  MainCoordinator.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 10/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import UIKit

// MARK: - Protocol

protocol MainFlow: class {
    func coordinateToTabBar()
}

// MARK: - Class

class MainCoordinator: Coordinator, MainFlow {

    // MARK: - Public Properties
    
    let navigationController: UINavigationController

    // MARK: - Initialization
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    //MARK: - Public methods

    func start() {
        guard let mainController = MainBuilder.buildViewController() else { return }
        mainController.coordinator = self
        navigationController.navigationBar.barTintColor = UIColor.black
        navigationController.navigationBar.isTranslucent = false
        navigationController.pushViewController(mainController, animated: true)
    }

    func coordinateToTabBar() {
        let tabBarCoordinator = TabBarCoordinator(navigationController: navigationController)
        coordinate(to: tabBarCoordinator)
    }
}
