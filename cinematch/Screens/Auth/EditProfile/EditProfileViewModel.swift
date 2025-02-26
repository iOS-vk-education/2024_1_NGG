//
//  EditProfileViewModel.swift
//  cinematch
//
//  Created by Ксения Панкратова on 17.12.2024.
//

import Foundation
import UIKit

final class EditProfileViewModel: EditProfileDisplayLogic & EditProfileViewModelInput {
    var inputName = ""
    var inputSurname = ""
    var inputEmail = ""
    var inputImage: UIImage? = nil
    var isPickerShow = false

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
}
