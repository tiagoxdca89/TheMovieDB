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
    var trailerURLString: Driver<String> { get }
    var movieDetail: Driver<Movie> { get }
    func saveToFavorites(poster: Data?, backDrop: Data?)
    func getTrailer()
}

// MARK: - Class

class DetailsViewModel: BaseViewModel {
    
    var movie: Movie
    let detailUseCase: DetailUseCaseProtocol
    let favoriteUseCase: FavoritesUseCaseProtocol
    let trailerUseCase: TrailerUseCaseProtocol
    
    var movieDetail: Driver<Movie> {
        return _movieDetail.asDriver(onErrorJustReturn: Movie())
    }
    
    var trailerURLString: Driver<String> {
        return _trailerURLString.asDriver(onErrorJustReturn: "")
    }
    
    private let _movieDetail = PublishSubject<Movie>()
    private let _trailerURLString = PublishSubject<String>()
    
    init(movie: Movie,
         useCase: DetailUseCaseProtocol,
         favoriteUseCase: FavoritesUseCaseProtocol,
         trailerUseCase: TrailerUseCaseProtocol) {
        self.movie = movie
        self.detailUseCase = useCase
        self.favoriteUseCase = favoriteUseCase
        self.trailerUseCase = trailerUseCase
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
    
    func getTrailer() {
        guard let id = movie.id else { return }
        trailerUseCase.getTrailer(movieID: id).asObservable()
            .subscribe(onNext: { [weak self] trailer in
                guard let key = trailer?.key else { return }
                let stringURL = String(format: API.Trailer.youtubePath, key)
                self?._trailerURLString.onNext(stringURL)
            }, onError: { (error: Error) in
                debugPrint("[ERROR] => \(error.localizedDescription)")
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
