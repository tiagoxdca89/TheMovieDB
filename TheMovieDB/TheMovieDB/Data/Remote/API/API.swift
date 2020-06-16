//
//  API.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 10/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import Foundation

struct API {
    static var baseUrl: String { "https://api.themoviedb.org/3" }
    private static let API_KEY = "7d8f773c003172eb742122984b193864"
    
  //MARK: - LastReleases APIs
    
  struct LastReleases {
      static let path = "/movie/now_playing"
      struct ParamKeys {
        static let apiKey = "api_key"
        static let language = "language"
        static let sortBy = "sort_by"
        static let includeAdult = "include_adult"
        static let includeVideo = "include_video"
        static let page = "page"
      }
  }
    
    struct MovieDetailsByID {
        static let path = "/movie/%d"
        struct ParamKeys {
          static let apiKey = "api_key"
          static let language = "language"
        }
    }
    
    struct MovieByTitle {
        static let path = "/search/movie"
        struct ParamKeys {
          static let apiKey = "api_key"
          static let query = "query"
          static let page = "page"
        }
    }
    
    struct TopRated {
        static let path = "/movie/top_rated"
        struct ParamKeys {
          static let apiKey = "api_key"
          static let language = "language"
          static let page = "page"
        }
    }
    
    struct Trailer {
        static let path = "/movie/%d/videos"
        static let youtubePath = "https://www.youtube.com/embed/%@"
        struct ParamKeys {
          static let apiKey = "api_key"
          static let language = "language"
        }
    }
    
    struct ImageMovie {
        static let path = "https://image.tmdb.org/t/p/w500%@"
    }
  
    //MARK: - Global Headers
    struct Headers {
        static let contentType = "Content-Type"
    }
    
    struct HeaderValues {
        static let Json = "application/json"
    }
    
    struct Parameters {
        static let APIKey = "api_key"
        static let LANGUAGE = "language"
    }
    
    struct ParametersValue {
        static let APIKeyValue = API.API_KEY
        static let LanguageValue = "en-US"
    }
    
  
}


