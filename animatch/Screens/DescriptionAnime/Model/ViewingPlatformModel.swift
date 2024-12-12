//
//  ViewingPlatformModel.swift
//  animatch
//
//  Created by Ксения Панкратова on 10.12.2024.
//

import Foundation

struct ViewingPlatformModel: Identifiable {
    let id: Int
    let title: String
    let image: Data
}

// MARK: - Mock Data

#if DEBUG
import UIKit

extension ViewingPlatformModel: Mockable {

    static var mockData: ViewingPlatformModel {
        ViewingPlatformModel(
            id: -1,
            title: "Start",
            image: UIImage.totoro1.pngData() ?? Data()
        )
    }
}
#endif
