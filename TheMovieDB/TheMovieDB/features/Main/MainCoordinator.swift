//
//  MainCoordinator.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 10/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import UIKit

protocol MainFlow: class {
    func coordinateToTabBar()
}

class MainCoordinator: Coordinator, MainFlow {

    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        guard let mainController = MainBuilder.buildViewController() else { return }
        mainController.coordinator = self
        navigationController.pushViewController(mainController, animated: true)
    }

    func coordinateToTabBar() {
        let tabBarCoordinator = TabBarCoordinator(navigationController: navigationController)
        coordinate(to: tabBarCoordinator)
    }
}
