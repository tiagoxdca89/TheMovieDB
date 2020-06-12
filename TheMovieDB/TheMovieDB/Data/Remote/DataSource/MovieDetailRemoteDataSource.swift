//
//  MovieDetailsRemoteDataSource.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 11/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import Foundation
import RxSwift

protocol MovieRemoteDataSourceProtocol {
    func getMovieDetail(_ id: Int) -> Single<Movie>
    func getMovieDetail(_ title: String) -> Single<MovieResponse>
}

class MovieRemoteDataSource: MovieRemoteDataSourceProtocol {
    
    let requestService: RequestServiceProtocol
    
    init(service: RequestServiceProtocol) {
        self.requestService = service
    }
    
    func getMovieDetail(_ id: Int) -> Single<Movie> {
        return requestService.request(MovieDetailsRequest.getMovieDetails(id: id))
    }
    
    func getMovieDetail(_ title: String) -> Single<MovieResponse> {
        return requestService.request(MovieDetailsRequest.getMovieByTitle(title: title))
    }
}
