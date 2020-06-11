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
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
     func start() {
         guard let detailViewController = DetailsBuilder.buildViewController() else { return }
         detailViewController.coordinator = self
        navigationController?.modalPresentationStyle = .overCurrentContext
        navigationController?.present(detailViewController, animated: true, completion: nil)
     }
}
