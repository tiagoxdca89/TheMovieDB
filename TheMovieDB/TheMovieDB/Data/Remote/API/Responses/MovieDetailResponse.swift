//
//  MovieDetailResponse.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 11/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import Foundation

struct MovieResponse {
    
    let results: [MovieDetail]
}

struct MovieDetail {
    
    var id: Int?
    var title: String?
    var poster_path: String?
    var backdrop_path: String?
    var overview: String?
    var release_date: String?
    var popularity: Double?
    var vote_average: Double?
    
    func getPosterEndPoint() -> String {
        guard let poster = poster_path else { return "" }
        return "https://image.tmdb.org/t/p/w500\(poster)"
    }
    
    func getBackDropURL() -> String? {
        guard let backdrop = backdrop_path else { return "" }
        return "https://image.tmdb.org/t/p/w500\(backdrop)"
    }
}
