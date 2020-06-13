//
//  FavoritesBuilder.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 10/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import UIKit
import CoreData

struct FavoritesBuilder {
    
    // MARK: Public methods
    
    static func buildViewController() -> FavoritesViewController? {
        let storyboard = UIStoryboard(name: Constants.Storyboard.Favorites, bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as? FavoritesViewController
        controller?.viewModel = buildViewModel()
        controller?.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
        return controller
    }
    
    private static func buildViewModel() -> FavoritesViewModelProtocol {
        let favoritesUseCase = buildFavoritesUseCase()
        return FavoritesViewModel(favoritesUseCase: favoritesUseCase)
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
