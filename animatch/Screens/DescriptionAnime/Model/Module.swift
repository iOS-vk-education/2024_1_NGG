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
    let imagesData: [Data]
    let similarMovies: [Data]
}

// MARK: - Mock Data

#if DEBUG
import UIKit

extension Module: Mockable {

    static var mockData: Module {
        Module(
            id: -1,
            title: "Title",
            director: "description",
            description: "fantasy",
            rating: 4,
            year: 1988,
            genre: "описание",
            imagesData: [
                UIImage.totoro1.pngData(),
                UIImage.totoro2.pngData(),
                UIImage.totoro3.pngData()
            ].compactMap { $0 },
            similarMovies: [
                UIImage.totoroSimilar1.pngData(),
                UIImage.totoroSimilar2.pngData(),
                UIImage.totoroSimilar3.pngData(),
                UIImage.totoroSimilar4.pngData()
            ].compactMap { $0 }
        )
    }
}
#endif
