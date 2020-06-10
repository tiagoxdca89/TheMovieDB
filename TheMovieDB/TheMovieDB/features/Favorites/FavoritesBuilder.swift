//
//  FavoritesBuilder.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 10/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import UIKit

struct FavoritesBuilder {
    
    // MARK: Public methods
    
    static func buildViewController() -> FavoritesViewController? {
        let storyboard = UIStoryboard(name: Constants.Storyboard.Favorites, bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as? FavoritesViewController
        return controller
    }
}
