//
//  MainBuilder.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 10/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import UIKit

struct MainBuilder {
    
    // MARK: Public methods
    
    static func buildViewController() -> MainViewController? {
        let storyboard = UIStoryboard(name: Constants.Storyboard.Main, bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as? MainViewController
        return controller
    }
}
