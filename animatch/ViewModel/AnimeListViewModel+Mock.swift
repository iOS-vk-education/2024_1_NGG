//
//  AnimeListViewModel+Mock.swift
//  animatch
//
//  Created by Ксения Панкратова on 27.11.2024.
//

import Foundation

#if DEBUG
extension AnimeListViewModel: Mockable {

    static var mockData: AnimeListViewModel {
        AnimeListViewModel(
            stories: (0...4).map { updateStoryID(item: .mockData, id: $0) }
        )
    }
}

private extension AnimeListViewModel {

    static func updateStoryID(item: Item, id: Int) -> Item {
        Item(
            id: id,
            title: item.title,
            type: item.type,
            genre: item.genre,
            date: item.date
        )
    }
}
#endif
