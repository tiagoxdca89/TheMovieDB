//
//  MovieDetailsRequest.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 10/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import Foundation

enum MovieDetailsRequest: URLRequestBuilder {
    
    case getMovieDetails(id: Int)
    case getMovieByTitle(title: String)
    
    var path: String {
        switch self {
        case .getMovieDetails(let id):
            return String(format: API.MovieDetailsByID.path, id)
        case .getMovieByTitle(_):
            return String(format: API.MovieByTitle.path)
        }
    }
    
    var parameters: [String : Any]? {
        var parameters: [String: Any] = [:]
        parameters[API.Parameters.APIKey] = API.ParametersValue.APIKeyValue
        parameters[API.Parameters.LANGUAGE] = API.ParametersValue.LanguageValue
        switch self {
        case .getMovieDetails(_):
            return parameters
        case .getMovieByTitle(let title):
            let name = title.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)
            parameters[API.MovieByTitle.ParamKeys.query] = name
            parameters[API.MovieByTitle.ParamKeys.page] = 1
            return parameters
        }
    }
}
