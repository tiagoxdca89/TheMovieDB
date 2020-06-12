//
//  DetailsBuilder.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 10/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import UIKit

struct DetailsBuilder {
    
    private static let requestService = RequestService.shared
    
    // MARK: Public methods
    
    static func buildViewController(movie: Movie) -> DetailsViewController? {
        let storyboard = UIStoryboard(name: Constants.Storyboard.Details, bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as? DetailsViewController
        controller?.viewModel = buildViewModel(movie: movie)
        return controller
    }
    
    private static func buildViewModel(movie: Movie) -> DetailsViewModelProtocol {
        let useCase = buildDetailUseCase()
        return DetailsViewModel(movie: movie, useCase: useCase)
    }
    
    private static func buildDetailUseCase() -> DetailUseCaseProtocol {
        let dataSource = MovieRemoteDataSource(service: requestService)
        return DetailUseCase(dataSource: dataSource)
    }
}
