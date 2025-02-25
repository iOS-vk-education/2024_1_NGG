//
//  MainEditProfileViewModel+Mock.swift
//  cinematch
//
//  Created by Ксения Панкратова on 23.12.2024.
//

#if DEBUG

import Foundation
import UIKit

final class MainEditProfileViewModelMock: MainEditProfileDisplayLogic {
    var inputName = ""
    var inputSurname = ""
    var inputEmail = ""
    var inputImage: UIImage? = nil

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
