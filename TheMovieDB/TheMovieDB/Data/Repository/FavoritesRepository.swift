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
    var fetchedResultsController: NSFetchedResultsController<FavoriteMovie> { get }
    func save(movie: Movie) -> Single<Void>
    func deleteMovie(at indexPath: IndexPath) -> Single<Void>
    func getFavorites() -> Single<[FavoriteMovie]>
}

class FavoritesRepository: FavoritesRepositoryProtocol {
    
    let coreDataManager: CoreDataManager
    var fetchedResultsController: NSFetchedResultsController<FavoriteMovie>
    
    init(coreDataManager: CoreDataManager, fetchedResultsController: NSFetchedResultsController<FavoriteMovie>) {
        self.coreDataManager = coreDataManager
        self.fetchedResultsController = fetchedResultsController
        setupFetchedResultsController()
    }
    
    private func setupFetchedResultsController() {
        let fetchRequest:NSFetchRequest<FavoriteMovie> = FavoriteMovie.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: coreDataManager.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("The fetch could not be performed: \(error.localizedDescription)")
        }
    }
    
    func save(movie: Movie) -> Single<Void> {
        guard let id = movie.id else { return .just(())}
        let fetchRequest: NSFetchRequest<FavoriteMovie> = FavoriteMovie.fetchRequest()
        let predicate: NSPredicate = NSPredicate(format: "id == %d", id)
        fetchRequest.predicate = predicate
        guard let result = try? coreDataManager.viewContext.fetch(fetchRequest),
            result.count == 0 else { return .just(()) }
        
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
    
    func deleteMovie(at indexPath: IndexPath) -> Single<Void> {
        
        return Single<Void>.create { [weak self] (observer) -> Disposable in
            guard let self = self else { return Disposables.create() }
            let movieToDelete = self.fetchedResultsController.object(at: indexPath)
            self.coreDataManager.viewContext.delete(movieToDelete)
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
