//
//  MovieCard.swift
//  cinematch
//
//  Created by Ксения Панкратова on 09.04.2025.
//

import Foundation

struct MovieCard {
    let id: Int
    let title: String
    let genre: String
    let type: String
    let year: Int
    let mainImage: Data
}

struct UIProperties: Hashable {
    var currentPage = 1
    var canLoadMorePages = true
    var isLoadingMore = false
}
