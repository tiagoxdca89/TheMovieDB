//
//  FavoritesCoordinator.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 10/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import UIKit

// MARK: - Protocol

protocol FavoriteFlow: class {
    func coordinateToDetail(movie: Movie)
}

// MARK: - Class

class FavoritesCoordinator: Coordinator, FavoriteFlow {
    
    // MARK: - Public Properties
    
    weak var navigationController: UINavigationController?
    
    // MARK: - Initialization
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    //MARK: - Public methods
    
    func start() {
        guard let favoritesController = FavoritesBuilder.buildViewController() else { return }
        favoritesController.coordinator = self
        navigationController?.pushViewController(favoritesController, animated: false)
    }
    
    func coordinateToDetail(movie: Movie) {
        guard let navigationController = navigationController else { return }
        let detailCoordinator = DetailsCoordinator(navigationController: navigationController, movie: movie)
        coordinate(to: detailCoordinator)
    }
}
