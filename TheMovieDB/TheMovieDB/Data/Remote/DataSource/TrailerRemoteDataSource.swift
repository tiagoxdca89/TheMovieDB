//
//  TrailerRemoteDataSource.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 11/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import Foundation
import RxSwift

protocol TrailerRemoteDataSourceProtocol {
    func getTrailer(movieID: Int) -> Single<TrailerResponse>
}

class TrailerRemoteDataSource: TrailerRemoteDataSourceProtocol {
    
    let requestService: RequestServiceProtocol
    
    init(service: RequestServiceProtocol) {
        self.requestService = service
    }
    
    func getTrailer(movieID: Int) -> Single<TrailerResponse> {
        return requestService.request(TrailerRequest.getTrailer(movieID: movieID))
    }
}
