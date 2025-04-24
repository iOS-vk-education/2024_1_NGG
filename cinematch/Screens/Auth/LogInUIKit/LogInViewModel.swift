//
//  LogInViewModel.swift
//  cinematch
//
//  Created by Ксения Панкратова on 17.03.2025.
//

import Foundation

final class LogInViewModel: LoginViewModelInput, LoginDisplayData, LoginViewModelDisplayLogic {
    var uiProperties = UserModel.UIProperties()
    @Published var showAlert = false
    @Published var errorMessage = ""
    @Published var isLoading = false

    private var startScreenViewModel: StartScreenViewModel?
    var interactor: LoginBusinessLogic?
}

// MARK: - LoginViewModelInput

extension LogInViewModel {
    func didTapLogInButton() {
        isLoading = true
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
        isLoading = false
        UserDefaults.standard.set(StartScreenState.movieList.rawValue, forKey: "State")
        startScreenViewModel?.updateScreen(newScreenState: .movieList)
    }

    func showErrorMessage(_ message: String) {
        isLoading = false
        showAlert = true
        errorMessage = message
    }
}
