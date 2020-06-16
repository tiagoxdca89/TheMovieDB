//
//  MovieDetailResponse.swift
//  TheMovieDB
//
//  Created by Tiago Xavier da Cunha Almeida on 11/06/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import UIKit

struct MovieResponse: Codable {
    let page: Int
    let total_pages: Int
    let results: [Movie]
}

struct Movie: Codable  {
    
    var id: Int?
    var title: String?
    var original_title: String?
    var homepage: String?
    var poster_path: String?
    var backdrop_path: String?
    var overview: String?
    var release_date: String?
    var popularity: Double?
    var vote_average: Double?
    var vote_count: Int?
    var video: Bool?
    var runtime: Int?
    var poster: Data?
    var backdrop: Data?
    var genres: [GenreModel]?
    
    func getPosterEndPoint() -> String {
        guard let poster = poster_path else { return "" }
        return "https://image.tmdb.org/t/p/w500\(poster)"
    }
    
    func getBackDropURL() -> String {
        guard let backdrop = backdrop_path else { return "" }
        return "https://image.tmdb.org/t/p/w500\(backdrop)"
    }
}

struct GenreModel: Codable {
    var id: Int?
    var name: String?
}
