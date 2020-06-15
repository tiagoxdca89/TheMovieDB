//
//  SearchViewModel.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 10/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol SearchViewModelProtocol: BaseViewModelProtocol {
    var dataSource: Driver <[Movie]> { get }
    var selectedMovie: Driver<Movie> { get }
    var selectedIndexPath: PublishSubject<IndexPath> { get set }
    func getTopRated()
    func searchBy(title: String)
}

class SearchViewModel: BaseViewModel {
    
    let searchUseCase: SearchMoviesUseCaseProtocol
    let topRatedUseCase: TopRatedUseCaseProtocol
    
    var dataSource: Driver<[Movie]> {
        return _dataSource.asDriver(onErrorJustReturn: [])
    }
    var selectedMovie: Driver<Movie> {
        return _selectedMovie.asDriver(onErrorJustReturn: Movie())
    }
    var selectedIndexPath = PublishSubject<IndexPath>()
    
    
    private var _dataSource = BehaviorSubject<[Movie]>(value: [])
    private var _selectedMovie = PublishSubject<Movie>()
    
    
    init(searchUseCase: SearchMoviesUseCaseProtocol, topRatedUseCase: TopRatedUseCaseProtocol) {
        self.searchUseCase = searchUseCase
        self.topRatedUseCase = topRatedUseCase
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        getTopRated()
    }
    
    private func setupBinding() {
        selectedIndexPath.map { $0.row }
        .subscribe(onNext: { [weak self] index in
            guard let self = self else { return }
            let movies = (try? self._dataSource.value()) ?? []
            let movie = movies[index]
            self._selectedMovie.onNext(movie)
        }, onError: { (error: Error) in
            debugPrint("[Error] = \(error)")
        })
        .disposed(by: bag)
    }
    
    func getTopRated() {
        topRatedUseCase.getTopRated().asObservable()
            .subscribe(onNext: { [weak self] movies in
                self?._dataSource.onNext(movies)
            }, onError: { (error: Error) in
                self.presentError(error: error)
            })
            .disposed(by: bag)
    }
    
    func searchBy(title: String) {
        searchUseCase.getMovies(title).asObservable()
            .subscribe(onNext: { [weak self] movies in
                self?._dataSource.onNext(movies)
            }, onError: { [weak self] (error: Error) in
                self?.presentError(error: error)
            })
            .disposed(by: bag)
    }
}

extension SearchViewModel: SearchViewModelProtocol {}
