//
//  DetailsViewModel.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 10/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import UIKit

// MARK: Protocol

protocol DetailsViewModelProtocol: BaseViewModelProtocol {
    
}

// MARK: - Class

class DetailsViewModel: BaseViewModel {
    
    let movie: Movie
    let useCase: DetailUseCaseProtocol
    
    init(movie: Movie, useCase: DetailUseCaseProtocol) {
        self.movie = movie
        self.useCase = useCase
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
    
    private func setupBindings() {
        useCase.getDetailMovie(movie: movie)
            .subscribe(onSuccess: { (movie) in
                print("===\(movie.title) = \(movie.poster_path)")
            }, onError: { (error: Error) in
                print("[ERROR] = \(error.localizedDescription)")
            })
            .disposed(by: bag)
    }
    
}

extension DetailsViewModel: DetailsViewModelProtocol {}


