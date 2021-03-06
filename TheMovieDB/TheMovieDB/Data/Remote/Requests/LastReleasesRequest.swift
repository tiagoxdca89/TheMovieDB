//
//  LastReleasesRequest.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 10/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import Foundation

enum LastReleasesRequest: URLRequestBuilder {
    
    case getLastReleases(page: Int)
    
    var path: String {
        switch self {
        case .getLastReleases(_):
            return String(format: API.LastReleases.path)
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .getLastReleases(let page):
            var parameters: [String: Any] = [:]
            parameters[API.Parameters.APIKey] = API.ParametersValue.APIKeyValue
            parameters[API.Parameters.LANGUAGE] = API.ParametersValue.LanguageValue
            parameters[API.LastReleases.ParamKeys.page] = page
            return parameters
        }
    }
}
