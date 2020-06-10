//
//  FavoritesViewController.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 10/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    var viewModel: FavoritesViewModelProtocol? {
        didSet { viewModel = oldValue ?? viewModel }
    }
    
    weak var coordinator: FavoritesCoordinator?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
