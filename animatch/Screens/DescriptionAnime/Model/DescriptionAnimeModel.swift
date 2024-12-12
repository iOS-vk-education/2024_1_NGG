//
//  DescriptionAnimeModel.swift
//  animatch
//
//  Created by Ксения Панкратова on 03.12.2024.
//

import Foundation

struct DescriptionAnimeModel {
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

// MARK: - Mapper

extension DescriptionAnimeModel {

    init(story: Module) {
        id = story.id
        title = story.title
        director = story.director
        description = story.description
        rating = story.rating
        year = story.year
        genre = story.genre
        imagesData = story.imagesData
        similarMovies = story.similarMovies
    }
}


// MARK: - Mock Data

#if DEBUG
import UIKit

extension DescriptionAnimeModel: Mockable {

    static var mockData: DescriptionAnimeModel {
        DescriptionAnimeModel(
            id: -1,
            title: "Мой сосед Тоторо",
            director: "Хаяо Миядзаки",
            description: "Сестры Сацуки и Мэй переезжают вместе с папой в деревенский дом. Однажды девочки обнаруживают, что по соседству с ними живут лесные духи — хранители леса во главе со своим могущественным и добрым повелителем Тоторо. Постепенно Тоторо становится другом девочек, помогая им в их повседневных приключениях.",
            rating: 4,
            year: 2021,
            genre: "приключения, фэнтези",
            imagesData: [
                UIImage.totoro1.pngData(),
                UIImage.totoro2.pngData(),
                UIImage.totoro3.pngData()
            ].compactMap { $0 },
            similarMovies:[
                UIImage.totoroSimilar1.pngData(),
                UIImage.totoroSimilar2.pngData(),
                UIImage.totoroSimilar3.pngData(),
                UIImage.totoroSimilar4.pngData()
            ].compactMap { $0 }
        )
    }
}
#endif
