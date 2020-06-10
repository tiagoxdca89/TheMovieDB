//
//  SearchCoordinator.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 10/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import UIKit

class SearchCoordinator: Coordinator {
    
   weak var navigationController: UINavigationController?
   
   init(navigationController: UINavigationController) {
       self.navigationController = navigationController
   }
   
    func start() {
        guard let searchViewController = SearchBuilder.buildViewController() else { return }
        searchViewController.coordinator = self
        navigationController?.pushViewController(searchViewController, animated: false)
    }
}
