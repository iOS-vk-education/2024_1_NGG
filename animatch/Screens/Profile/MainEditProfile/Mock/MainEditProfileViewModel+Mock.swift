//
//  MainEditProfileViewModel+Mock.swift
//  animatch
//
//  Created by Ксения Панкратова on 23.12.2024.
//

#if DEBUG

import Foundation

final class MainEditProfileViewModelMock: MainEditProfileViewModelLogic {
    var inputName = ""
    var inputSurname = ""
    var inputEmail = ""

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
}

#endif
