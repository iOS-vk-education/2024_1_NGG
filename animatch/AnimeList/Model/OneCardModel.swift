//
//  OneCardModel.swift
//  animatch
//
//  Created by Ксения Панкратова on 28.11.2024.
//

import Foundation

struct OneCardModel {
    let id: Int
    let title: String
    let type: String
    let genre: String
    let date: String
}

// MARK: - Mapper

extension OneCardModel {

    init(story: Item) {
        id = story.id
        title = story.title
        type = story.type
        genre = story.genre
        date = story.date.formatted(.dateTime.year())
    }
}

// MARK: - Mock Data

#if DEBUG
extension OneCardModel: Mockable {

    static var mockData: OneCardModel {
        OneCardModel(
            id: -1,
            title: "Тоторо",
            type: "Фильм",
            genre: "Приключения",
            date: "1988"
        )
    }
}
#endif
