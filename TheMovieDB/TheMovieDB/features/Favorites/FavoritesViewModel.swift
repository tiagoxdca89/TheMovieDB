//
//  FavoritesViewModel.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 10/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import CoreData

protocol FavoritesViewModelProtocol: BaseViewModelProtocol {
    var dataSource: Driver <[FavoriteMovie]> { get }
    var selectedMovie: Driver<FavoriteMovie> { get }
    var indexToDelete: Driver<IndexPath> { get }
    var selectedIndexPath: PublishSubject<IndexPath> { get set }
    var deleteOnIndexPath: PublishSubject<IndexPath> { get set }
    func convertMovie(favorite: FavoriteMovie) -> Movie
    func viewWillAppear()
}

class FavoritesViewModel: BaseViewModel {
    
    var dataSource: Driver<[FavoriteMovie]> {
        return _dataSource.asDriver(onErrorJustReturn: [])
    }
    var selectedMovie: Driver<FavoriteMovie> {
        return _selectedMovie.asDriver(onErrorJustReturn: FavoriteMovie())
    }
    
    var indexToDelete: Driver<IndexPath> {
        return _indexToDelete.asDriver(onErrorJustReturn: IndexPath())
    }
    
    var selectedIndexPath = PublishSubject<IndexPath>()
    var deleteOnIndexPath = PublishSubject<IndexPath>()
    
    private var _dataSource = BehaviorSubject<[FavoriteMovie]>(value: [])
    private var _selectedMovie = PublishSubject<FavoriteMovie>()
    private var _indexToDelete = PublishSubject<IndexPath>()
    private var isFirstTime: Bool = true
    
    let favoritesUseCase: FavoritesUseCaseProtocol
    
    init(favoritesUseCase: FavoritesUseCaseProtocol) {
        self.favoritesUseCase = favoritesUseCase
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
    }
    
    func viewWillAppear() {
        getFavorites()
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
        
        deleteOnIndexPath
            .subscribe(onNext: { [weak self] indexPath in
                self?.deleteMovie(at: indexPath)
                }, onError: { (error: Error) in
                    debugPrint("[Error] = \(error)")
            })
            .disposed(by: bag)
        
    }
    
    private func deleteMovie(at indexpath: IndexPath) {
        favoritesUseCase.deleteMovieAt(indexPath: indexpath)
            .asObservable()
            .subscribe(onNext: { [weak self] _ in
                self?.getFavorites()
//                guard let self = self else { return }
//                var movies = (try? self._dataSource.value()) ?? []
//                movies.remove(at: indexpath.row)
//                self?._indexToDelete.onNext(indexpath)
                }, onError: { (error: Error) in
                    debugPrint("\(error.localizedDescription)")
            })
            .disposed(by: bag)
    }
    
    private func getFavorites() {
        favoritesUseCase.getFavorites().asObservable()
            .subscribe(onNext: { [weak self] favoriteMovies in
                self?._dataSource.onNext(favoriteMovies)
                }, onError: { (error: Error) in
                    debugPrint("")
            })
            .disposed(by: bag)
    }
    
    func convertMovie(favorite: FavoriteMovie) -> Movie {
        return Movie(id: Int(favorite.id), title: favorite.title, original_title: favorite.original_title, homepage: favorite.homepage, poster_path: favorite.poster_path, backdrop_path: favorite.backdrop_path, overview: favorite.overview, release_date: favorite.release_date, popularity: favorite.popularity, vote_average: favorite.vote_average, vote_count: Int(favorite.vote_count), video: false, runtime: Int(favorite.runtime), genres: convertGenders(genders: favorite.genres?.allObjects as? [Genre] ))
    }
    
    private func convertGenders(genders: [Genre]?) -> [GenreModel] {
        guard let genders = genders else { return [] }
        var _genders: [GenreModel] = []
        for genre in genders {
            let genreModel = GenreModel(id: Int(genre.id), name: genre.name)
            _genders.append(genreModel)
        }
        return _genders
    }
}

extension FavoritesViewModel: FavoritesViewModelProtocol {}
