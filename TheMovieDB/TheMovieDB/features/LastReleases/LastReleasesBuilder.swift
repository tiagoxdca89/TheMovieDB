//
//  LastReleasesBuilder.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 10/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import UIKit

struct LastReleasesBuilder {
    
    // MARK: Public methods
    
    static func buildViewController() -> LastReleasesViewController? {
        let storyboard = UIStoryboard(name: Constants.Storyboard.LastReleases, bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as? LastReleasesViewController
        controller?.tabBarItem = UITabBarItem(tabBarSystemItem: .mostRecent, tag: 0)
        return controller
    }
}
