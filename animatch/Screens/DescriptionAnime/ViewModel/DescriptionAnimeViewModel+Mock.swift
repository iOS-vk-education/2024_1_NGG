//
//  DescriptionAnimeViewModel+Mock.swift
//  animatch
//
//  Created by Ксения Панкратова on 03.12.2024.
//

import Foundation

#if DEBUG
extension DescriptionAnimeViewModel: Mockable {

    static var mockData: DescriptionAnimeViewModel {
        DescriptionAnimeViewModel(
        )
    }
}

private extension DescriptionAnimeViewModel {

    static func updateStoryID(item: Module, id: Int) -> Module {
        Module(
            id: id,
            title: item.title,
            director: item.director,
            description: item.description,
            rating: item.rating,
            year: item.year,
            genre: item.genre

        )
    }
}
#endif
