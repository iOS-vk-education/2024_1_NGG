//
//  LogInViewModel.swift
//  cinematch
//
//  Created by Ксения Панкратова on 17.03.2025.
//

import Foundation

final class LogInViewModel: LoginViewModelInput, LoginDisplayData, LoginViewModelDisplayLogic {
    @Published var uiProperties = UserModel.UIProperties()

    private var startScreenViewModel: StartScreenViewModel?
    var interactor: LoginBusinessLogic?
}

// MARK: - LoginViewModelInput

extension LogInViewModel {
    func didTapLogInButton() {
        uiProperties.isLoading = true
        interactor?.logIn(email: uiProperties.email, password: uiProperties.password)
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
        uiProperties.isLoading = false
        UserDefaults.standard.set(StartScreenState.movieList.rawValue, forKey: "State")
        startScreenViewModel?.updateScreen(newScreenState: .movieList)
    }

    func showErrorMessage(_ message: String) {
        uiProperties.isLoading = false
        uiProperties.showAlert = true
        uiProperties.errorMessage = message
    }
}
