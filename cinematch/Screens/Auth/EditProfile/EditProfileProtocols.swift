//
//  EditProfileProtocols.swift
//  cinematch
//
//  Created by Ксения Панкратова on 17.12.2024.
//

import Foundation
import UIKit
import _PhotosUI_SwiftUI

protocol EditProfileDisplayLogic: EditProfileViewModelInput {
    var bindingData: BindingData { get set }
}

protocol EditProfileViewModelInput {
    func setStartScreenViewModel(_ startScreenViewModel: StartScreenViewModel)
    func didTapSaveButton()
    func didTapDoLaterButton()
    func selectedItemChange(_ newItem: PhotosPickerItem?)
}
