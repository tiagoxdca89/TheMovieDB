//
//  LastReleasesCoordinator.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 10/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import UIKit

protocol LastReleasesFlow: class {
    func coordinateToDetail(movie: Movie)
}

class LastReleasesCoordinator: Coordinator, LastReleasesFlow {
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
     func start() {
         guard let lastReleasesController = LastReleasesBuilder.buildViewController()
            else { return }
         lastReleasesController.coordinator = self
         navigationController?.pushViewController(lastReleasesController, animated: false)
     }
    
    func coordinateToDetail(movie: Movie) {
        guard let navigationController = navigationController else { return }
        let detailCoordinator = DetailsCoordinator(navigationController: navigationController, movie: movie)
        coordinate(to: detailCoordinator)
    }
}

