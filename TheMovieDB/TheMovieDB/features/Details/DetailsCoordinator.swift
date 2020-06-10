//
//  DetailsCoordinator.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 10/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import UIKit

// MARK: - Class

class DetailsCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    weak var parentCoordinator: Coordinator?
    
    var navigationController: UINavigationController = UINavigationController()
//    private var parentNavigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        guard let controller = DetailsBuilder.buildViewController() else { return }
        controller.coordinator = self
        DispatchQueue.main.async {
            self.navigationController.pushViewController(controller, animated: true)
        }
    }
}
