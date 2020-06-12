//
//  TopRatedDataSource.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 12/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import Foundation
import RxSwift

protocol TopRatedRemoteDataSourceProtocol {
    func getTopRated() -> Single<MovieResponse>
}

class TopRatedRemoteDataSource: TopRatedRemoteDataSourceProtocol {
    
    
    let requestService: RequestServiceProtocol
    
    init(service: RequestServiceProtocol) {
        self.requestService = service
    }
    
    func getTopRated() -> Single<MovieResponse> {
        return requestService.request(TopRatedRequest.getTopRatedMovies)
    }
    
}
