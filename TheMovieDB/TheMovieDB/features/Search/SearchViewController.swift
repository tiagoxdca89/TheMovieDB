//
//  SearchViewController.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 10/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    var viewModel: SearchViewModelProtocol? {
        didSet { viewModel = oldValue ?? viewModel }
    }
    
    weak var coordinator: SearchCoordinator?


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
