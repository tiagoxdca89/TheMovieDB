//
//  TopRatedRequest.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 10/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import Foundation

enum TopRatedRequest: URLRequestBuilder {
    
    case getTopRatedMovies(page: Int)
    
    var path: String {
        switch self {
        case .getTopRatedMovies:
            return API.TopRated.path
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .getTopRatedMovies(let page):
            var parameters: [String: Any] = [:]
            parameters[API.Parameters.APIKey] = API.ParametersValue.APIKeyValue
            parameters[API.Parameters.LANGUAGE] = API.ParametersValue.LanguageValue
            parameters[API.TopRated.ParamKeys.page] = page
            return parameters
        }
    }
}
