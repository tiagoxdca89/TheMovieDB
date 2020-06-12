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
    let movie: Movie
    
    init(navigationController: UINavigationController, movie: Movie) {
        self.navigationController = navigationController
        self.movie = movie
    }
    
     func start() {
        guard let detailViewController = DetailsBuilder.buildViewController(movie: movie) else { return }
        detailViewController.coordinator = self
        navigationController?.modalPresentationStyle = .overCurrentContext
        navigationController?.present(detailViewController, animated: true, completion: nil)
     }
}
