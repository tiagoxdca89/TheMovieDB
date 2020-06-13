//
//  DetailsViewModel.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 10/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

// MARK: Protocol

protocol DetailsViewModelProtocol: BaseViewModelProtocol {
    var movieDetail: Driver<Movie> { get }
    func saveToFavorites(poster: Data?, backDrop: Data?)
}

// MARK: - Class

class DetailsViewModel: BaseViewModel {
    
    var movie: Movie
    let detailUseCase: DetailUseCaseProtocol
    let favoriteUseCase: FavoritesUseCaseProtocol
    
    var movieDetail: Driver<Movie> {
        return _movieDetail.asDriver(onErrorJustReturn: Movie())
    }
    
    private let _movieDetail = PublishSubject<Movie>()
    
    init(movie: Movie, useCase: DetailUseCaseProtocol, favoriteUseCase: FavoritesUseCaseProtocol) {
        self.movie = movie
        self.detailUseCase = useCase
        self.favoriteUseCase = favoriteUseCase
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
    
    func saveToFavorites(poster: Data?, backDrop: Data?) {
        movie.poster = poster
        movie.backdrop = backDrop
        favoriteUseCase.save(movie: movie).asObservable().subscribe(onNext: { _ in
            debugPrint("[SAVED]")
        }, onError: { (error: Error) in
            debugPrint("[ERROR] => \(error)")
        })
            .disposed(by: bag)
    }
    
    private func setupBindings() {
        detailUseCase.getDetailMovie(movie: movie)
            .subscribe(onSuccess: { [weak self] (movie) in
                self?._movieDetail.onNext(movie)
            }, onError: { (error: Error) in
                print("[ERROR] = \(error.localizedDescription)")
            })
            .disposed(by: bag)
    }
    
}

extension DetailsViewModel: DetailsViewModelProtocol {}
