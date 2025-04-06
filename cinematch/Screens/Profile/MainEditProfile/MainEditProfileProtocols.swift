//
//  MainEditProfileProtocols.swift
//  cinematch
//
//  Created by Ксения Панкратова on 23.12.2024.
//

import Foundation
import UIKit
import _PhotosUI_SwiftUI

protocol MainEditProfileDisplayLogic: MainEditProfileViewModelInput {
    var bindingData: BindingData { get set }
    var prevViewModel: MainProfileViewModelInput { get }
}

protocol MainEditProfileViewModelInput {
    func didTapSaveButton()
    func setCoordinator(_ coordinator: NavigationControllerCoordinator)
    func selectedItemChange(_ newItem: PhotosPickerItem?)
}
