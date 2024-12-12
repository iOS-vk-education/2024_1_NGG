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
        DescriptionAnimeViewModel(stories: .mockData,
                                  views: (1...4).map { updateViewID(view: .mockData, id: String($0)) })
    }
}

private extension DescriptionAnimeViewModel {
    
    static func updateViewID(view: ViewingPlatformModel, id: String) -> ViewingPlatformModel {
        ViewingPlatformModel(
            id: id,
            title: view.title,
            imageData: view.imageData
        )
    }
}
#endif
