//
//  MainViewController.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 10/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var coordinator: MainFlow?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.layoutIfNeeded()
        showLoading(show: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.showLoading(show: false)
            self.coordinator?.coordinateToTabBar()
        }
    }
    
    @IBAction func showTabBar(_ sender: Any) {
        print("Clicou aqui")
        
    }
}
