//
//  Module.swift
//  cinematch
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

struct ViewingPlatformModel: Identifiable, Hashable {
    let id: String
    let title: String
    let imageData: Data
}

// MARK: - Mock Data

#if DEBUG

import UIKit

extension ViewingPlatformModel: Mockable {

    static var mockData: ViewingPlatformModel {
        ViewingPlatformModel(
            id: UUID().uuidString,
            title: "Start",
            imageData: UIImage(resource: .start).pngData() ?? Data()
        )
    }

    static func generateViewingPlatforms(id: String) -> ViewingPlatformModel {
        ViewingPlatformModel(
            id: id,
            title: "Start",
            imageData: UIImage(resource: .start).pngData() ?? Data()
        )
    }
}

#endif
