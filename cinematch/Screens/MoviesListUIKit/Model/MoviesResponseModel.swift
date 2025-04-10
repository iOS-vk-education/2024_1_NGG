//
//  MoviesResponseModel.swift
//  cinematch
//
//  Created by Ксения Панкратова on 06.04.2025.
//

import Foundation

struct MoviesResponseModel: Codable {
    let docs: [Movie]
    let total: Int
    let limit: Int
    let page: Int
    let pages: Int
}

struct Movie: Codable {
    let id: Int
    let name: String
    let type: String
    let genres: [Genres]
    let year: Int
    let poster: Poster
}

struct MovieDescription: Codable {
    let id: Int
    let name: String?
    let type: String?
    let year: Int?
    let description: String?
    let rating: Rating?
    let poster: Poster?
    let genres: [Genres]
    let similarMovies: [SimilarMovies]?
    let watchability: Watchability?
}

struct Rating: Codable {
    let kp: Double?
}

struct Poster: Codable {
    let url: String
}

struct Genres: Codable {
    let name: String
}

struct Persons: Codable {
    let id: Int
    let name: String?
    let profession: String?
}

struct SimilarMovies: Codable {
    let id: Int
    let poster: Poster
}

struct Watchability: Codable {
    let items: [ViewingPlatforms]?
}

struct ViewingPlatforms: Codable {
    let name: String?
    let logo: Logo?
    let url: String?
}

struct Logo: Codable {
    let url: String?
}
