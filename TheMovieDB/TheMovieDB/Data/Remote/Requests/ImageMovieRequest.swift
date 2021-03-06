//
//  ImageMovieRequest.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 10/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import Foundation

enum ImageMovieRequest: URLRequestBuilder {
    
    case getMovieImage
    
    var path: String {
        switch self {
        case .getMovieImage:
            return API.ImageMovie.path
        }
    }
}
