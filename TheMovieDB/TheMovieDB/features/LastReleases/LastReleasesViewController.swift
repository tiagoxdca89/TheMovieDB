//
//  LastReleasesViewController.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 10/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import UIKit

class LastReleasesViewController: UIViewController {
    
    var viewModel: LastReleasesViewModelProtocol? {
        didSet { viewModel = oldValue ?? viewModel }
    }
    
    weak var coordinator: LastReleasesCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}
