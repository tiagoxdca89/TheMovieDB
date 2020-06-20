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

// MARK: Protocol

protocol FavoritesViewModelProtocol: BaseViewModelProtocol {
    var fetchedResultsController: NSFetchedResultsController<FavoriteMovie> { get }
    func deleteMovie(at indexpath: IndexPath)
    func convertMovie(favorite: FavoriteMovie?) -> Movie
}

// MARK: - Class

class FavoritesViewModel: BaseViewModel {
    
    // MARK: - Private properties
    
    private let favoritesUseCase: FavoritesUseCaseProtocol
    
    // MARK: - Public properties
    
    var fetchedResultsController: NSFetchedResultsController<FavoriteMovie> {
        return favoritesUseCase.fetchedResultsController
    }
    
    // MARK: - Initialization
    
    init(favoritesUseCase: FavoritesUseCaseProtocol) {
        self.favoritesUseCase = favoritesUseCase
    }
    
    // MARK: - Public methods
    
    func deleteMovie(at indexpath: IndexPath) {
        favoritesUseCase.deleteMovieAt(indexPath: indexpath)
            .asObservable()
            .subscribe(onNext: { _ in
                print("Movie deleted")
            }, onError: { [weak self] (error: Error) in
                self?.presentError(error: error)
            })
            .disposed(by: bag)
    }
}

extension FavoritesViewModel: FavoritesViewModelProtocol {
    
    // MARK: - Helper methods
    
    func convertMovie(favorite: FavoriteMovie?) -> Movie {
        guard let favorite = favorite else { return Movie() }
        
        return Movie(id: Int(favorite.id), title: favorite.title, original_title: favorite.original_title, homepage: favorite.homepage, poster_path: favorite.poster_path, backdrop_path: favorite.backdrop_path, overview: favorite.overview, release_date: favorite.release_date, popularity: favorite.popularity, vote_average: favorite.vote_average, vote_count: Int(favorite.vote_count), video: false, runtime: Int(favorite.runtime), poster: ((favorite.poster) as? UIImage)?.pngData(), backdrop: ((favorite.backdrop) as? UIImage)?.pngData(), favorite: true, genres: convertGenders(genders: favorite.genres?.allObjects as? [Genre]))
    }
    
    private func convertGenders(genders: [Genre]?) -> [GenreModel] {
        guard let genders = genders else { return [] }
        var _genders: [GenreModel] = []
        for genre in genders {
            let genreModel = GenreModel(name: genre.name)
            _genders.append(genreModel)
        }
        return _genders
    }
}
