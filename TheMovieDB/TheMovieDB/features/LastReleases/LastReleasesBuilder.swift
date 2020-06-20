//
//  LastReleasesBuilder.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 10/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import UIKit

struct LastReleasesBuilder {
    
    private static let requestService = RequestService.shared
    
    // MARK: Public methods
    
    static func buildViewController() -> LastReleasesViewController? {
        let storyboard = UIStoryboard(name: Constants.Storyboard.LastReleases, bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as? LastReleasesViewController
        controller?.viewModel = buildViewModel()
        controller?.tabBarItem = UITabBarItem(tabBarSystemItem: .mostRecent, tag: 0)
        return controller
    }
    
    // MARK: Private methods
    
    private static func buildViewModel() -> LastReleasesViewModelProtocol {
        let useCase = buildLastReleasesUseCase()
        return LastReleasesViewModel(useCase: useCase)
    }
    
    private static func buildLastReleasesUseCase() -> LastReleasesUseCaseProtocol {
        let remoteDataSource = LastReleasesRemoteDataSource(service: requestService)
        let useCase = LastReleasesUseCase(remoteDataSource: remoteDataSource)
        return useCase
    }
}
