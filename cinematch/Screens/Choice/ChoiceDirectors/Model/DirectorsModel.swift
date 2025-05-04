//
//  DirectorsModel.swift
//  cinematch
//
//  Created by Ксения Панкратова on 18.12.2024.
//

import Foundation

struct Directors: Identifiable {
    let id: Int
    let name: String
    var isSelected: Bool
}

extension Directors {
    init(name: String, isSelected: Bool) {
        self.id = Int.random(in: 10000...99999)
        self.name = name
        self.isSelected = isSelected
    }
}
