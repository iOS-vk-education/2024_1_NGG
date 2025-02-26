//
//  EditProfileViewModel.swift
//  cinematch
//
//  Created by Ксения Панкратова on 17.12.2024.
//

import Foundation
import UIKit
import _PhotosUI_SwiftUI

@Observable
final class EditProfileViewModel: EditProfileDisplayLogic & EditProfileViewModelInput {
    var bindingData: BindingData = BindingData()

    @ObservationIgnored
    private var startScreenViewModel: StartScreenViewModel?
}

// MARK: - EditProfileViewModelInput

extension EditProfileViewModel {
    func setStartScreenViewModel(_ startScreenViewModel: StartScreenViewModel) {
        self.startScreenViewModel = startScreenViewModel
    }

    func didTapSaveButton() {
        startScreenViewModel?.updateScreen(newScreenState: .choiceGenres)
        UserDefaults.standard.set(StartScreenState.choiceGenres.rawValue, forKey: "State")
        UserDefaults.standard.removeObject(forKey: "selectedGenres")
    }

    func didTapDoLaterButton() {
        startScreenViewModel?.updateScreen(newScreenState: .choiceGenres)
        UserDefaults.standard.set(StartScreenState.choiceGenres.rawValue, forKey: "State")
        UserDefaults.standard.removeObject(forKey: "selectedGenres")
    }

    func selectedItemChange(_ newItem: PhotosPickerItem?) {
        Task {
            if let imageData = try? await newItem?.loadTransferable(type: Data.self) {
                self.bindingData.inputImage = UIImage(data: imageData)
            }
        }
    }
}
