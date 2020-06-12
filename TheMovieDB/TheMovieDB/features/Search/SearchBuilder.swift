//
//  SearchBuilder.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 10/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import UIKit

struct SearchBuilder {
    
    private static let requestService = RequestService.shared
    
    // MARK: Public methods
    
    static func buildViewController() -> SearchViewController? {
        let storyboard = UIStoryboard(name: Constants.Storyboard.Search, bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as? SearchViewController
        controller?.viewModel = buildViewModel()
        controller?.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        return controller
    }
    
    private static func buildViewModel() -> SearchViewModelProtocol {
        let topRatedUseCase = buildTopRatedUseCase()
        let searchUseCase = buildSearchUseCase()
        return SearchViewModel(searchUseCase: searchUseCase, topRatedUseCase: topRatedUseCase)
    }
    
    private static func buildTopRatedUseCase() -> TopRatedUseCaseProtocol {
        let dataSource = TopRatedRemoteDataSource(service: requestService)
        return TopRatedUseCase(remoteDataSource: dataSource)
    }
    
    private static func buildSearchUseCase() -> SearchMoviesUseCaseProtocol {
        let dataSource = MovieRemoteDataSource(service: requestService)
        return SearchMoviesUseCase(remoteDataSource: dataSource)
    }
}
