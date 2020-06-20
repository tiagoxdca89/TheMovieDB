//
//  DetailUseCase.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 12/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import Foundation
import RxSwift

// MARK: Protocol

protocol DetailUseCaseProtocol {
    func getDetailMovie(movie: Movie) -> Single<Movie>
}

// MARK: Class

class DetailUseCase: DetailUseCaseProtocol {
    
    private let dataSource: MovieRemoteDataSourceProtocol
    
    // MARK: - Initialization
    
    init(dataSource: MovieRemoteDataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    func getDetailMovie(movie: Movie) -> Single<Movie> {
        guard let id = movie.id else { return .error(GenericError.invalidType) }
        return dataSource.getMovieDetail(id)
    }
    
}
