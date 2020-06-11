//
//  FavoritesRepository.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 11/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import Foundation
import RxSwift
import CoreData
import Kingfisher

protocol FavoritesRepositoryProtocol {
    func save(movie: Movie) -> Single<Void>
    func deletePhoto(at index: IndexPath) -> Single<Void>
    func getFavorites() -> Single<[FavoriteMovie]>
}

class FavoritesRepository: FavoritesRepositoryProtocol {
    
    let coreDataManager: CoreDataManager
    let fetchedResultsController: NSFetchedResultsController<FavoriteMovie>
    
    init(coreDataManager: CoreDataManager, fetchedResultsController: NSFetchedResultsController<FavoriteMovie>) {
        self.coreDataManager = coreDataManager
        self.fetchedResultsController = fetchedResultsController
    }
    
    
    
    func save(movie: Movie) -> Single<Void> {
        
        return Single<Void>.create { [weak self] (observer) -> Disposable in
            guard let self = self else { return Disposables.create() }
            
            let favorite = FavoriteMovie(context: self.coreDataManager.viewContext)
            favorite.id = Int32(movie.id ?? 0)
            favorite.title = movie.title
            favorite.overview = movie.overview
            favorite.popularity = movie.popularity ?? 0.0
            favorite.vote_average = movie.vote_average ?? 0.0
            favorite.release_date = movie.release_date
            favorite.poster = DataLoader.getData(with: movie.poster_path)
            favorite.backdrop = DataLoader.getData(with: movie.backdrop_path)
            if self.coreDataManager.viewContext.hasChanges {
                try? self.coreDataManager.viewContext.save()
                observer(.success(()))
            }
            return Disposables.create()
        }
    }
    
    func deletePhoto(at index: IndexPath) -> Single<Void> {
        
        return Single<Void>.create { [weak self] (observer) -> Disposable in
            guard let self = self else { return Disposables.create() }
            let movie = self.fetchedResultsController.object(at: index)
            self.coreDataManager.viewContext.delete(movie)
            try? self.coreDataManager.viewContext.save()
            observer(.success(()))
            return Disposables.create()
        }
    }
    
    func getFavorites() -> Single<[FavoriteMovie]> {
        guard let photos = fetchedResultsController.fetchedObjects else { return Single.just([]) }
        return Single.just(photos)
        
    }
}
