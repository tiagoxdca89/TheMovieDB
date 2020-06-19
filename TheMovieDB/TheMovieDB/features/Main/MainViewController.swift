//
//  MainViewController.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 10/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import UIKit
import Lottie

class MainViewController: UIViewController {
    
    @IBOutlet weak var animationView: LottieView!
    
    var coordinator: MainFlow?

    override func viewDidLoad() {
        super.viewDidLoad()
        startAnimating()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.coordinator?.coordinateToTabBar()
        }
    }
    
    private func startAnimating() {
        let checkMarkAnimation =  AnimationView(name: "animation")
        animationView.contentMode = .scaleAspectFit
        animationView.addSubview(checkMarkAnimation)
        checkMarkAnimation.frame = animationView.bounds
        checkMarkAnimation.loopMode = .playOnce
        checkMarkAnimation.play()
    }
    
}
