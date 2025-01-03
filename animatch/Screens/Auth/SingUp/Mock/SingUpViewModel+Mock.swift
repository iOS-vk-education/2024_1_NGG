//
//  SingUpViewModel+Mock.swift
//  animatch
//
//  Created by Ксения Панкратова on 14.12.2024.
//

#if DEBUG

import Foundation

@Observable
final class SingUpViewModelMock: SingUpViewModelLogic {
    var inputEmail = ""
    var inputPasswordFirst = ""
    var inputPasswordSecond = ""

    @ObservationIgnored
    private var startScreenViewModel: StartScreenViewModel?
}

// MARK: - SingUpViewModelInput

extension SingUpViewModelMock {

    func setStartScreenViewModel(_ startScreenViewModel: StartScreenViewModel) {
        self.startScreenViewModel = startScreenViewModel
    }

    func didTapContinue() {
        startScreenViewModel?.updateScreen(newScreenState: .editProfile)
        UserDefaults.standard.set(StartScreenState.editProfile.rawValue, forKey: "State")
    }

    func didTapOpenSignInScreen() {
        startScreenViewModel?.updateScreen(newScreenState: .signIn)
    }
}

#endif
