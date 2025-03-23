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
    var receiveUserData = UserModel.User()

    private var startScreenViewModel: StartScreenViewModel?
    var interactor: LoginBusinessLogic?
}

// MARK: - LoginViewModelInput

extension LogInViewModel {
    func didTapLogInButton() {
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
    func logInSuccess(userData: UserModel.User) {
        receiveUserData = userData
        UserDefaults.standard.set(StartScreenState.movieList.rawValue, forKey: "State")
        startScreenViewModel?.updateScreen(newScreenState: .movieList)
    }

    func showErrorMessage(_ message: String) {
        showAlert = true
        errorMessage = message
    }
}
