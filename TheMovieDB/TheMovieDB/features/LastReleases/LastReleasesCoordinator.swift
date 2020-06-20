//
//  LastReleasesCoordinator.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 10/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import UIKit

// MARK: - Protocol

protocol LastReleasesFlow: class {
    func coordinateToDetail(movie: Movie)
}

// MARK: - Class

class LastReleasesCoordinator: Coordinator, LastReleasesFlow {
    
    // MARK: - Public Properties
    
    weak var navigationController: UINavigationController?
    
    // MARK: - Initialization
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    //MARK: - Public methods
    
    func start() {
        guard let lastReleasesController = LastReleasesBuilder.buildViewController()
            else { return }
        lastReleasesController.coordinator = self
        navigationController?.pushViewController(lastReleasesController, animated: false)
    }
    
    func coordinateToDetail(movie: Movie) {
        if InternetManager.shared.isConnectedToInternet {
            guard let navigationController = navigationController else { return }
            let detailCoordinator = DetailsCoordinator(navigationController: navigationController, movie: movie)
            coordinate(to: detailCoordinator)
        } else {
            MessageManager.shared.present(error: RemoteFetchError.noInternet)
        }
    }
}

