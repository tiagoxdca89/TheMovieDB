//
//  FavoritesCoordinator.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 10/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import UIKit

protocol FavoriteFlow: class {
    func coordinateToDetail(movie: Movie)
}

class FavoritesCoordinator: Coordinator, FavoriteFlow {
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
     func start() {
         guard let favoritesController = FavoritesBuilder.buildViewController() else { return }
        
         favoritesController.coordinator = self
         navigationController?.pushViewController(favoritesController, animated: false)
     }
    
    func coordinateToDetail(movie: Movie) {
        if InternetManager.shared.isConnectedToInternet {
        guard let navigationController = navigationController else { return }
        let detailCoordinator = DetailsCoordinator(navigationController: navigationController, movie: movie)
        coordinate(to: detailCoordinator)
        } else {
            debugPrint("Show No Internet message")
        }
    }
}
