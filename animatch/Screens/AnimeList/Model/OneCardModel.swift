//
//  OneCardModel.swift
//  animatch
//
//  Created by Ксения Панкратова on 28.11.2024.
//

import Foundation

struct OneCardModel {
    let id: Int
    let mainImage: Data
    let title: String
    let type: String
    let genre: String
    let year: Int
}

// MARK: - Mapper

extension OneCardModel {

    init(story: Module) {
        id = story.id
        mainImage = story.mainImage
        title = story.title
        type = story.type
        genre = story.genre
        year = story.year
    }
}

// MARK: - Mock Data

#if DEBUG
import UIKit

extension OneCardModel: Mockable {

    static var mockData: OneCardModel {
        OneCardModel(
            id: -1,
            mainImage: UIImage.totoro1.pngData()!,
            title: "Тоторо",
            type: "Фильм",
            genre: "Приключения",
            year: 1988
        )
    }
}
#endif
