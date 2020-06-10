//
//  DetailsBuilder.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 10/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import UIKit

struct DetailsBuilder {
    
    // MARK: Public methods
    
    static func buildViewController() -> DetailsViewController? {
        let storyboard = UIStoryboard(name: Constants.Storyboard.Details, bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as? DetailsViewController
        return controller
    }
}
