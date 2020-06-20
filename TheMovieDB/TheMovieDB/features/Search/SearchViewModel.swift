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

// MARK: Protocol

protocol SearchViewModelProtocol: BaseViewModelProtocol {
    var emptyList: Driver<Bool> { get }
    var dataSource: Driver <[Movie]> { get }
    var selectedMovie: Driver<Movie> { get }
    var selectedIndexPath: PublishSubject<IndexPath> { get set }
    var loadNextPage: PublishSubject<Void> { get set }
    func getTopRated()
    func searchBy(title: String)
    var moviesCount: Int { get }
}

// MARK: - Class

class SearchViewModel: BaseViewModel {
    
    // MARK: - Public properties
    
    var moviesCount: Int {
        return movies.count
    }
    
    var emptyList: Driver<Bool> {
        return _emptyList.asDriver(onErrorJustReturn: false)
    }
    
    var dataSource: Driver<[Movie]> {
        return _dataSource.asDriver(onErrorJustReturn: [])
    }
    var selectedMovie: Driver<Movie> {
        return _selectedMovie.asDriver(onErrorJustReturn: Movie())
    }
    var selectedIndexPath = PublishSubject<IndexPath>()
    var loadNextPage = PublishSubject<Void>()
    
    // MARK: - Private properties
    
    private let searchUseCase: SearchMoviesUseCaseProtocol
    private let topRatedUseCase: TopRatedUseCaseProtocol
    private var _dataSource = BehaviorSubject<[Movie]>(value: [])
    private var _selectedMovie = PublishSubject<Movie>()
    private var _emptyList = PublishSubject<Bool>()
    private var movies: [Movie] = []
    private var isLoaging = false
    private var page: Int = 0
    private var totalPages = 500
    
    // MARK: - Initialization
    
    init(searchUseCase: SearchMoviesUseCaseProtocol,
         topRatedUseCase: TopRatedUseCaseProtocol) {
        self.searchUseCase = searchUseCase
        self.topRatedUseCase = topRatedUseCase
    }
    
    // MARK: - Overridden methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        getTopRated()
    }
    
    // MARK: - Private methods
    
    private func setupBinding() {
        
        loadNextPage.asObservable()
            .subscribe(onNext: { [weak self] _ in
                self?.getTopRated()
                }, onError: { [weak self] (error: Error) in
                    self?.presentError(error: error)
            })
            .disposed(by: bag)
        
        selectedIndexPath.map { $0.row }
            .subscribe(onNext: { [weak self] index in
                guard let self = self else { return }
                self._selectedMovie.onNext(self.movies[index])
                }, onError: { [weak self] (error: Error) in
                    self?.presentError(error: error)
            })
            .disposed(by: bag)
    }
    
    // MARK: - Public methods
    
    func getTopRated() {
        let canRequest = moviesCount != totalPages && page <= totalPages && !isLoaging
        page += 1
        if canRequest {
            isLoaging = true
            topRatedUseCase.getTopRated(page: page).asObservable()
                .subscribe(onNext: { [weak self] result in
                    guard let self = self else { return }
                    self.movies.append(contentsOf: result.movies)
                    self._dataSource.onNext(self.movies)
                    self.isLoaging = false
                    self._emptyList.onNext(self.movies.count == 0)
                    }, onError: { [weak self] (error: Error) in
                        self?.presentError(error: error)
                        self?._emptyList.onNext(self?.movies.count == 0)
                        self?.isLoaging = false
                })
                .disposed(by: bag)
        }
    }
    
    func searchBy(title: String) {
        searchUseCase.getMovies(title)
            .asObservable()
            .subscribe(onNext: { [weak self] movies in
                self?._dataSource.onNext(movies)
            }, onError: { [weak self] (error: Error) in
                self?.presentError(error: error)
            })
            .disposed(by: bag)
    }
}

extension SearchViewModel: SearchViewModelProtocol {}
