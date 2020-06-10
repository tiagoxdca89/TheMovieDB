//
//  MainCoordinator.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 10/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import UIKit

class MainCoordinator: NSObject, Coordinator {
    
    var childCoordinators = [Coordinator]()
    weak var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }
    
    // MARK: - Public methods
    
    func start() {
        guard let controller = MainBuilder.buildViewController() else { return }
        controller.coordinator = self
        controller.modalPresentationStyle = .fullScreen
        navigationController.delegate = self
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.viewControllers = [controller]
    }
    
    func showTabBar() {
        let child = TabBarCoordinator(navigationController: navigationController)
        childCoordinators.append(child)
        child.start()
    }
    
}

extension MainCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        debugPrint("")
    }
}
