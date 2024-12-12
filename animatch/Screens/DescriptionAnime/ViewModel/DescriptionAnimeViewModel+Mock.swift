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
        DescriptionAnimeViewModel(stories: .mockData, views: .mockData)
    }
}
#endif
