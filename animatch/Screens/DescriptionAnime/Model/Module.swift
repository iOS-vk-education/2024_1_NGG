//
//  Module.swift
//  animatch
//
//  Created by Ксения Панкратова on 03.12.2024.
//

import Foundation

struct Module: Identifiable, Hashable {
    let id: Int
    let mainImage: Data
    let title: String
    let director: String
    let description: String
    let rating: Int
    let type: String
    let year: Int
    let genre: String
    let imagesData: [Data]
    let similarMovies: [Module]
    let viewingPlatforms: [ViewingPlatformModel]
}
