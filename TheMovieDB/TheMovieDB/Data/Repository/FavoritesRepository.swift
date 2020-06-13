//
//  FavoritesRepository.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 11/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import UIKit
import RxSwift
import CoreData

protocol FavoritesRepositoryProtocol {
    func save(movie: Movie) -> Single<Void>
    func deleteMovie(at index: IndexPath) -> Single<Void>
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
            favorite.genres = NSSet(array: movie.genres ?? [])
            favorite.poster_path = movie.poster_path
            favorite.backdrop_path = movie.backdrop_path
            favorite.poster = UIImage(data: movie.poster ?? Data())
            favorite.backdrop = UIImage(data: movie.backdrop ?? Data())
            if self.coreDataManager.viewContext.hasChanges {
                try? self.coreDataManager.viewContext.save()
                observer(.success(()))
            }
            return Disposables.create()
        }
    }
    
    func deleteMovie(at index: IndexPath) -> Single<Void> {
        let fetchRequest: NSFetchRequest<FavoriteMovie> = FavoriteMovie.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        guard let movies = try? coreDataManager.viewContext.fetch(fetchRequest) else { return .just(()) }
        
        return Single<Void>.create { [weak self] (observer) -> Disposable in
            guard let self = self else { return Disposables.create() }
            self.coreDataManager.viewContext.delete(movies[index.row])
            try? self.coreDataManager.viewContext.save()
            observer(.success(()))
            return Disposables.create()
        }
    }
    
    func getFavorites() -> Single<[FavoriteMovie]> {
        let fetchRequest: NSFetchRequest<FavoriteMovie> = FavoriteMovie.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        guard let movies = try? coreDataManager.viewContext.fetch(fetchRequest) else { return Single.just([]) }
        
        return Single.just(movies)
    }
}
