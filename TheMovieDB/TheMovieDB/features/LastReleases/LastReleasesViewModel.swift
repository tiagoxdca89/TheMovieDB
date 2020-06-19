//
//  LastReleasesViewModel.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 10/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol LastReleasesViewModelProtocol: BaseViewModelProtocol {
    var moviesCount: Int { get }
    var emptyList: Driver<Bool> { get }
    var dataSource: Driver <[Movie]> { get }
    var selectedMovie: Driver<Movie> { get }
    var selectedIndexPath: PublishSubject<IndexPath> { get set }
    var loadNextPage: PublishSubject<Void> { get set }
}

class LastReleasesViewModel: BaseViewModel {
    
    var moviesCount: Int {
        return movies.count
    }
    
    var emptyList: Driver<Bool> {
        return _emptyList.asDriver(onErrorJustReturn: true)
    }
    
    var dataSource: Driver<[Movie]> {
        return _dataSource.asDriver(onErrorJustReturn: [])
    }
    
    var selectedMovie: Driver<Movie> {
        return _selectedMovie.asDriver(onErrorJustReturn: Movie())
    }
    
    var selectedIndexPath = PublishSubject<IndexPath>()
    
    var loadNextPage = PublishSubject<Void>()
    
    let lastReleasesUseCase: LastReleasesUseCaseProtocol
    
    // MARK: - Private properties
    
    private var _dataSource = BehaviorSubject<[Movie]>(value: [])
    private var _selectedMovie = PublishSubject<Movie>()
    private var _emptyList = PublishSubject<Bool>()
    private var movies: [Movie] = []
    private var isLoaging = false
    private var page: Int = 0
    private var totalPages = 500
    
    init(useCase: LastReleasesUseCaseProtocol) {
        self.lastReleasesUseCase = useCase
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        getLastReleases()
    }
    
    private func setupBindings() {
        
        loadNextPage.asObservable()
            .subscribe(onNext: { [weak self] _ in
                self?.getLastReleases()
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
    
    private func getLastReleases() {
        let canRequest = moviesCount != totalPages && page <= totalPages && !isLoaging
        page += 1
        if canRequest {
            isLoaging = true
            lastReleasesUseCase.getLastReleases(page: page)
                .asObservable()
                .subscribe(onNext: { [weak self] (result: MoviesResult) in
                    guard let self = self else { return }
                    self.movies.append(contentsOf: result.movies)
                    self._dataSource.onNext(self.movies)
                    self.totalPages = result.totalPages
                    self.isLoaging = false
                    self._emptyList.onNext(self.movies.count == 0)
                    }, onError: { [weak self] (error: Error) in
                        self?.presentError(error: error)
                        self?._emptyList.onNext(self?.movies.count == 0)
                        self?.isLoaging = false
                }).disposed(by: bag)
        }
    }
}

extension LastReleasesViewModel: LastReleasesViewModelProtocol {}
