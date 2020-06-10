//
//  SearchBuilder.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 10/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import UIKit

struct SearchBuilder {
    
    // MARK: Public methods
    
    static func buildViewController() -> SearchViewController? {
        let storyboard = UIStoryboard(name: Constants.Storyboard.Search, bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as? SearchViewController
        return controller
    }
}
