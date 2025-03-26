//
//  SavedUserModel.swift
//  cinematch
//
//  Created by Ксения Панкратова on 26.03.2025.
//

import UIKit

struct SavedUserModel: Hashable {
    var id: String
    var name: String
    var surname: String
    var email: String
    var imageState: ImageState
}

enum ImageState: Hashable {
    case loading(url: String?)
    case fetched(ImageKind)
    case failed
}

enum ImageKind: Hashable {
    case data(Data)
    case uiImage(UIImage)
}
