//
//  SavedUserModel.swift
//  cinematch
//
//  Created by Ксения Панкратова on 26.03.2025.
//

import UIKit

enum ImageState: Hashable {
    case loading(url: String?)
    case fetched(ImageKind)
    case failed
}

enum ImageKind: Hashable {
    case data(Data)
    case uiImage(UIImage)
}
