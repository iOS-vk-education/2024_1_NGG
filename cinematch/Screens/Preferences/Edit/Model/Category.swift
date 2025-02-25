//
//  Category.swift
//  cinematch
//
//  Created by Ксения Панкратова on 10.01.2025.
//

import Foundation

enum Category: String, CaseIterable, Identifiable {
    case genres = "Жанры"
    case directors = "Режиссёры"

    var id: String { self.rawValue }
}
