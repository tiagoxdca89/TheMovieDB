//
//  LastReleasesCoordinator.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 10/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import UIKit

class LastReleasesCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    weak var parentCoordinator: Coordinator?
    
    var navigationController: UINavigationController = UINavigationController()
//    private var parentNavigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        guard let controller = LastReleasesBuilder.buildViewController() else { return }
        controller.coordinator = self
        navigationController.viewControllers = [controller]
        navigationController.modalPresentationStyle = .fullScreen
        let icon = UIImage(named: Constants.TabBarIcons.LastReleases)
        navigationController.tabBarItem = UITabBarItem(title: Constants.TabBarNames.LastReleases, image: icon, tag: 0)
    }
}

