//
//  EditProfileProtocols.swift
//  cinematch
//
//  Created by Ксения Панкратова on 17.12.2024.
//

import Foundation
import _PhotosUI_SwiftUI

protocol EditProfileDisplayLogic {
    var bindingData: BindingData { get set }
    var isSaving: Bool { get }
    var showAlert: Bool { get set }
    var errorMessage: String { get set }
}

protocol EditProfileViewModelInput {
    func setStartScreenViewModel(_ startScreenViewModel: StartScreenViewModel)
    func didTapSaveButton()
    func selectedItemChange(_ newItem: PhotosPickerItem?)
    func validateFields() -> Bool
}
