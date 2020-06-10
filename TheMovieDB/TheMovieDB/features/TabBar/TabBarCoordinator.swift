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
    
    var childCoordinators = [Coordinator]()
    weak var parentCoordinator: Coordinator?
    var navigationController: UINavigationController = UINavigationController()
    private var parentNavigationController: UINavigationController
    
    // MARK: - Initialization
    
    init(navigationController: UINavigationController) {
        self.parentNavigationController = navigationController
    }
    
    func start() {
        let result = TabBarBuilder.buildViewControllerAndCoordinators()
        let tabBar = result.tabBar
        let coordinators = result.coordinators
        
        tabBar.coordinator = self
        tabBar.delegate = self
        tabBar.modalPresentationStyle = .fullScreen
        tabBar.tabBar.tintColor = .blue
        tabBar.tabBar.unselectedItemTintColor = .black
        
        navigationController.viewControllers = [tabBar]
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.modalPresentationStyle = .fullScreen
        
        DispatchQueue.main.async {
            self.parentNavigationController.present(self.navigationController, animated: false, completion: nil)

            for coordinator in coordinators {
                coordinator.parentCoordinator = self
                self.childCoordinators.append(coordinator)
                coordinator.start()
            }

            if let selectedController = tabBar.viewControllers?[tabBar.selectedIndex] {
                self.reorderCoordinators(viewController: selectedController)
            }
        }
    }
}

extension TabBarCoordinator: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        reorderCoordinators(viewController: viewController)
        return true
    }
    
    func reorderCoordinators(viewController: UIViewController) {
      let coordinators = childCoordinators.filter{ $0.navigationController === viewController }
      if let coordinator = coordinators.first {
        childCoordinators = childCoordinators.filter{ !($0.navigationController === viewController) }
        childCoordinators.append(coordinator)
      }
    }
}
