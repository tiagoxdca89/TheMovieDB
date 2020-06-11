//
//  SearchMoviesUseCase.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 11/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import Foundation
import RxSwift

protocol SearchMoviesUseCaseProtocol {
    func getMovies(_ title: String) -> Single<[Movie]>
}

class SearchMoviesUseCase: SearchMoviesUseCaseProtocol {
    
    private let remoteDataSource: MovieRemoteDataSourceProtocol
    
    init(remoteDataSource: MovieRemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    func getMovies(_ title: String) -> Single<[Movie]> {
        remoteDataSource.getMovieDetail(title).map { $0.results }
    }
}
