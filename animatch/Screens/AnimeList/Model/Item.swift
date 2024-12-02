//
//  Item.swift
//  animatch
//
//  Created by Ксения Панкратова on 27.11.2024.
//

import Foundation

struct Item: Identifiable {
    let id: Int
    let title: String
    let type: String
    let genre: String
    let date: Date
}

// MARK: - Mock Data

#if DEBUG
extension Item: Mockable {

    static var mockData: Item {
        Item(
            id: -1,
            title: "Title",
            type: "film",
            genre: "fantasy",
            date: Date.now
        )
    }
}
#endif
