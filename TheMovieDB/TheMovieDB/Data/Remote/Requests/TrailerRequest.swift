//
//  TrailerRequest.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 10/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import Foundation

enum TrailerRequest: URLRequestBuilder {
    
    case getTrailer
    
    var path: String {
        switch self {
        case .getTrailer:
            return API.Trailer.path
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .getTrailer:
            var parameters: [String: Any] = [:]
            parameters[API.Parameters.APIKey] = API.ParametersValue.APIKeyValue
            parameters[API.Parameters.LANGUAGE] = API.ParametersValue.LanguageValue
            return parameters
        }
    }
}
