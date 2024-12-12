//
//  ViewingPlatformModel.swift
//  animatch
//
//  Created by Ксения Панкратова on 12.12.2024.
//

import Foundation

struct ViewingPlatformModel: Identifiable {
    let id: String
    let title: String
    let imageData: Data
}

// MARK: - Mock Data

#if DEBUG
import SwiftUI

extension ViewingPlatformModel: Mockable {

    static var mockData: ViewingPlatformModel {
        ViewingPlatformModel(
            id: UUID().uuidString,
            title: "Start",
            imageData: UIImage(resource: .start).pngData() ?? Data()
        )
    }
}
#endif
