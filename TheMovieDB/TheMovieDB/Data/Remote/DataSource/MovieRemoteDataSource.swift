//
//  MovieRemoteDataSource.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 11/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import Foundation
import RxSwift

protocol LastReleasesRemoteDataSourceProtocol {
    func getMovie() -> Single<MovieResponse>
}

class LastReleasesRemoteDataSource: LastReleasesRemoteDataSourceProtocol {
    
    let requestService: RequestServiceProtocol
    
    init(service: RequestServiceProtocol) {
        self.requestService = service
    }
    
    func getMovie() -> Single<MovieResponse> {
        return requestService.request()
    }
}
