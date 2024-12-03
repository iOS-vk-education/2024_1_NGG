//
//  Module.swift
//  animatch
//
//  Created by Ксения Панкратова on 03.12.2024.
//

import Foundation

struct Module: Identifiable {
    let id: Int
    let title: String
    let director: String
    let description: String
    let rating: Int
    let year: Int
    let genre: String
}

// MARK: - Mock Data

#if DEBUG
extension Module: Mockable {

    static var mockData: Module {
        Module(
            id: -1,
            title: "Title",
            director: "description",
            description: "fantasy",
            rating: 4,
            year: 1988,
            genre: "описание"
        )
    }
}
#endif
