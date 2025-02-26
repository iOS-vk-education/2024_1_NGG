//
//  MainEditProfileViewModel+Mock.swift
//  cinematch
//
//  Created by Ксения Панкратова on 23.12.2024.
//

#if DEBUG

import Foundation
import UIKit
import _PhotosUI_SwiftUI

@Observable
final class MainEditProfileViewModelMock: MainEditProfileDisplayLogic {
    var bindingData: BindingData = BindingData()

    @ObservationIgnored
    private var coordinator: Coordinator?
}

// MARK: - MainEditProfileViewModelInput

extension MainEditProfileViewModelMock {

    func setCoordinator(_ coordinator: Coordinator) {
        self.coordinator = coordinator
    }

    func didTapSaveButton() {
        coordinator?.openPreviousScreen()
    }

    func selectedItemChange(_ newItem: PhotosPickerItem?) {
        Task {
            if let imageData = try? await newItem?.loadTransferable(type: Data.self) {
                self.bindingData.inputImage = UIImage(data: imageData)
            }
        }
    }
}

#endif
