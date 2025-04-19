//
//  MovieService.swift
//  cinematch
//
//  Created by Ксения Панкратова on 06.04.2025.
//

import Foundation

enum APIConstants {
    static let apiKey = "TDJZ4GD-4PYM6B1-KMRA1Z2-H2BD233"
//    static let apiKey = "ZPTA2RA-AHJMPX1-JGTTJHD-TCX496M"
}

protocol MovieServiceProtocol {
    var baseUrl: String { get }
    var path: String { get }
    var method: String { get }
    var header: [String: String] { get }
}

enum MovieService: MovieServiceProtocol {
    case recMovies(genres: [String], directors: [Int], page: Int)
    case descriptionMovie(id: Int)

    var baseUrl: String {
        return "https://api.kinopoisk.dev/v1.4"
    }

    var path: String {
        switch self {
        case .recMovies:
            return "/movie"

        case .descriptionMovie(let id):
            return "/movie/\(id)"
        }
    }

    var parameters: [String: Any]? {
        switch self {
        case .recMovies(let genres, let directors, let page):
            return [
                "sortField": "votes.kp",
                "sortType": "-1",
                "notNullFields": [
                    "name",
                    "description",
                    "poster.url",
                    "type",
                    "year",
                    "genres.name"
                ],
                "genres.name": genres,
                "limit": "20",
                "page": "\(page)",
                "persons.id": directors,
            ]
        case .descriptionMovie(_):
            return nil
        }
    }

    var method: String {
        return "GET"
    }

    var header: [String: String] {
        return [
            "X-API-KEY": APIConstants.apiKey,
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
    }
}
