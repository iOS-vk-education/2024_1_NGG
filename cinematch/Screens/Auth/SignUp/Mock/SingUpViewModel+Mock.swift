//
//  SignUpViewModel+Mock.swift
//  cinematch
//
//  Created by Ксения Панкратова on 14.12.2024.
//

#if DEBUG

import Foundation

@Observable
final class SignUpViewModelMock: SignUpViewModelLogic {
    var inputEmail = ""
    var inputPasswordFirst = ""
    var inputPasswordSecond = ""

    @ObservationIgnored
    private var startScreenViewModel: StartScreenViewModel?
}

// MARK: - SignUpViewModelInput

extension SignUpViewModelMock {

    func setStartScreenViewModel(_ startScreenViewModel: StartScreenViewModel) {
        self.startScreenViewModel = startScreenViewModel
    }

    func didTapContinue() {
        startScreenViewModel?.updateScreen(newScreenState: .editProfile)
        UserDefaults.standard.set(StartScreenState.editProfile.rawValue, forKey: "State")
    }

    func didTapOpenSignInScreen() {
        startScreenViewModel?.updateScreen(newScreenState: .logIn)
    }
}

#endif
