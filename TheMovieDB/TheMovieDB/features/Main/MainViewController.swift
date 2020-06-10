//
//  MainViewController.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 10/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import UIKit
import Foundation

class MainViewController: UIViewController {
    
    weak var coordinator: MainCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        showLoading(show: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showLoading(show: false)
        }
    }

}
