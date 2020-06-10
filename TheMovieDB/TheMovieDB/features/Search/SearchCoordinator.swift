//
//  SearchCoordinator.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 10/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import UIKit

class SearchCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    weak var parentCoordinator: Coordinator?
    
    var navigationController: UINavigationController = UINavigationController()
//    private var parentNavigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        guard let controller = SearchBuilder.buildViewController() else { return }
        controller.coordinator = self
        navigationController.viewControllers = [controller]
        navigationController.modalPresentationStyle = .fullScreen
        let icon = UIImage(named: Constants.TabBarIcons.Search)
        navigationController.tabBarItem = UITabBarItem(title: Constants.TabBarNames.Search, image: icon, tag: 1)
    }
}
