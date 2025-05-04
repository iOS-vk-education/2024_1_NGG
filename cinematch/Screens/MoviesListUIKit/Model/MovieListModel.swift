//
//  MovieListModel.swift
//  cinematch
//
//  Created by Ксения Панкратова on 13.04.2025.
//

import Foundation

enum MovieListModel {}

extension MovieListModel {
    struct UIProperties: Hashable {
        var currentPage = 1
        var totalPages = 2
        var isLoading = false
        var isLastPage = false
    }
}
