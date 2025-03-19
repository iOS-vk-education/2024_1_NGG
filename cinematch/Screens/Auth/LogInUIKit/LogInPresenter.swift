//
//  LogInPresenter.swift
//  cinematch
//
//  Created by Ксения Панкратова on 16.03.2025.
//

final class LogInPresenter: PresenterInput {
    weak var viewModel: LoginViewModelDisplayLogic!

    func didLogInSuccess() {
        viewModel.logInSuccess()
    }

    func didLogInFailure(error: Error) {
        viewModel.showErrorMessage(error.localizedDescription)
    }
}
