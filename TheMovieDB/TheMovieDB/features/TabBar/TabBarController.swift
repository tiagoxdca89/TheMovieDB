//
//  TabBarController.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 10/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import UIKit

// MARK: - Class

class TabBarController: UITabBarController {
    
    // MARK: - Public properties
    
    var coordinator: TabBarCoordinator?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        debugPrint("Did load TabBarController")
    }
}
