//
//  Module+Mock.swift
//  animatch
//
//  Created by Ксения Панкратова on 14.12.2024.
//

#if DEBUG

import UIKit

extension Module {

    static var mockData: Module {
        let tempStory = Module.generateStory(number: -1)
        return Module(
            id: tempStory.id,
            mainImage: [
                UIImage.totoro1.pngData(),
                UIImage.totoro2.pngData(),
                UIImage.totoro3.pngData(),
                UIImage.totoroSimilar1.pngData()
            ].compactMap { $0 }.randomElement() ?? Data(),
            title: tempStory.title,
            director: tempStory.director,
            description: tempStory.description,
            rating: tempStory.rating,
            type: tempStory.type,
            year: tempStory.year,
            genre: tempStory.genre,
            imagesData: tempStory.imagesData,
            similarMovies: (1...4).map { .generateStory(number: $0) },
            viewingPlatforms: (1...3).map { .generateViewingPlatforms(id: String($0)) }
        )
    }

    static func generateStory(number: Int) -> Module {
        Module(
            id: number,
            mainImage: [
                UIImage.totoro1.pngData(),
                UIImage.totoro2.pngData(),
                UIImage.totoro3.pngData(),
                UIImage.totoroSimilar1.pngData()
            ].compactMap { $0 }.randomElement() ?? Data(),
            title: "Мой сосед Тоторо #\(number)",
            director: "Хаяо Миядзаки #\(number)",
            description: "Сестры Сацуки и Мэй переезжают вместе с папой в деревенский дом. Однажды девочки обнаруживают, что по соседству с ними живут лесные духи — хранители леса во главе со своим могущественным и добрым повелителем Тоторо. Постепенно Тоторо становится другом девочек",
            rating: Int.random(in: 1...5),
            type: ["Фильм", "Сериал"].randomElement()!,
            year: Int.random(in: 1980...2024),
            genre: "приключения, фэнтези",
            imagesData: [
                UIImage(resource: .totoro1).pngData(),
                UIImage(resource: .totoro2).pngData(),
                UIImage(resource: .totoro3).pngData(),
            ].shuffled().compactMap { $0 },
            similarMovies: [],
            viewingPlatforms: (1...3).map { .generateViewingPlatforms(id: String($0)) }
        )
    }
}

#endif
