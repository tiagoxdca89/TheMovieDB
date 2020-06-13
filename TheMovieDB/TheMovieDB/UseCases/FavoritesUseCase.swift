//
//  FavoritesUseCase.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 11/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import Foundation
import RxSwift

protocol FavoritesUseCaseProtocol {
    func getFavorites() -> Single<[FavoriteMovie]>
    func save(movie: Movie) -> Single<Void>
    func deleteMovieAt(indexPath: IndexPath) -> Single<Void>
}

class FavoritesUseCase: FavoritesUseCaseProtocol {
    
    private let repository: FavoritesRepositoryProtocol
    
    init(repository: FavoritesRepositoryProtocol) {
        self.repository = repository
    }
    
    func getFavorites() -> Single<[FavoriteMovie]> {
        return self.repository.getFavorites()
    }
    
    func save(movie: Movie) -> Single<Void> {
        return repository.save(movie: movie)
    }
    
    func deleteMovieAt(indexPath: IndexPath) -> Single<Void> {
        return repository.deleteMovie(at: indexPath)
    }
}
