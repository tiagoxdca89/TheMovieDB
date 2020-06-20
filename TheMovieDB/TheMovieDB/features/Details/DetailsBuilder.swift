//
//  DetailsBuilder.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 10/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import UIKit
import CoreData

struct DetailsBuilder {
    
    private static let requestService = RequestService.shared
    
    // MARK: Public methods
    
    static func buildViewController(movie: Movie) -> DetailsViewController? {
        let storyboard = UIStoryboard(name: Constants.Storyboard.Details, bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as? DetailsViewController
        controller?.viewModel = buildViewModel(movie: movie)
        return controller
    }
    
    // MARK: Private methods
    
    private static func buildViewModel(movie: Movie) -> DetailsViewModelProtocol {
        let useCase = buildDetailUseCase()
        let favoritesUseCase = buildFavoritesUseCase()
        let trailerUseCase = buildTrailerUseCase()
        return DetailsViewModel(movie: movie,
                                useCase: useCase,
                                favoriteUseCase: favoritesUseCase,
                                trailerUseCase: trailerUseCase)
    }
    
    private static func buildDetailUseCase() -> DetailUseCaseProtocol {
        let dataSource = MovieRemoteDataSource(service: requestService)
        return DetailUseCase(dataSource: dataSource)
    }
    
    private static func buildTrailerUseCase() -> TrailerUseCaseProtocol {
        let remoteDataSource = TrailerRemoteDataSource(service: requestService)
        return TrailerUseCase(remoteDataSource: remoteDataSource)
    }
    
    private static func buildFavoritesUseCase() -> FavoritesUseCaseProtocol {
        let managerCD = appDelegate.coreDataManager
        let fetchedController = NSFetchedResultsController<FavoriteMovie>()
        let repository = FavoritesRepository(coreDataManager: managerCD, fetchedResultsController: fetchedController)
        return FavoritesUseCase(repository: repository)
    }
    
    private static var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
}
