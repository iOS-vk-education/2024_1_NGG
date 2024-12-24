//
//  EditProfileViewModel.swift
//  animatch
//
//  Created by Ксения Панкратова on 17.12.2024.
//

import Foundation

final class EditProfileViewModel: EditProfileViewModelLogic & EditProfileViewModelInput {
    var inputName = ""
    var inputSurname = ""
    var inputEmail = ""

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
    }

    func didTapDoLaterButton() {
        startScreenViewModel?.updateScreen(newScreenState: .choiceGenres)
        UserDefaults.standard.set(StartScreenState.choiceGenres.rawValue, forKey: "State")
    }
}
