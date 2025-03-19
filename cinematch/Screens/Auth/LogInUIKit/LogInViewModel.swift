//
//  LogInViewModel.swift
//  cinematch
//
//  Created by Ксения Панкратова on 17.03.2025.
//

import Foundation

final class LogInViewModel: LoginViewModelInput, LoginDisplayData, LoginViewModelDisplayLogic {

    @Published var email: String = ""
    @Published var password: String = ""
    var uiProperties = UserModel.UIProperties()

    private var startScreenViewModel: StartScreenViewModel?
    var interactor: LoginBusinessLogic?
}

// MARK: - LoginViewModelInput

extension LogInViewModel {
    func didTapLogInButton() async {
        await interactor?.logIn(email: email, password: password)
    }

    func didTapOpenRegistrationScreen() {
        startScreenViewModel?.updateScreen(newScreenState: .signUp)
    }

    func setStartScreenViewModel(_ startScreenViewModel: StartScreenViewModel) {
        self.startScreenViewModel = startScreenViewModel
    }
}

// MARK: - LoginViewModelDisplayLogic

extension LogInViewModel {
    func logInSuccess() {
        uiProperties.showAlert = false
        UserDefaults.standard.set(StartScreenState.movieList.rawValue, forKey: "State")
        startScreenViewModel?.updateScreen(newScreenState: .movieList)
    }

    func showErrorMessage(_ message: String) {
        uiProperties.showAlert = true
        uiProperties.errorMessage = message
    }
}
