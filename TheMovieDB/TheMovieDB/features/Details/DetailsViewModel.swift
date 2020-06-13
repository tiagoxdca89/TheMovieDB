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
}

var id: Int?
var title: String?
var homepage: String?
var poster_path: String?
var backdrop_path: String?
var overview: String?
var release_date: String?
var popularity: Double?
var vote_average: Double?
var vote_count: Int?
var video: Bool?
var runtime: Int?

// MARK: - Class

class DetailsViewModel: BaseViewModel {
    
    let movie: Movie
    let useCase: DetailUseCaseProtocol
    
    var movieDetail: Driver<Movie> {
        return _movieDetail.asDriver(onErrorJustReturn: Movie())
    }
    
    private let _movieDetail = PublishSubject<Movie>()
    
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
            .subscribe(onSuccess: { [weak self] (movie) in
                self?._movieDetail.onNext(movie)
            }, onError: { (error: Error) in
                print("[ERROR] = \(error.localizedDescription)")
            })
            .disposed(by: bag)
    }
    
}

extension DetailsViewModel: DetailsViewModelProtocol {}
