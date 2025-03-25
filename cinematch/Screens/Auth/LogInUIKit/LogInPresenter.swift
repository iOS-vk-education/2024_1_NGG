//
//  LogInPresenter.swift
//  cinematch
//
//  Created by Ксения Панкратова on 16.03.2025.
//

import Foundation
import UIKit

final class LogInPresenter: PresenterInput {
    weak var viewModel: LoginViewModelDisplayLogic!

    func didLogInSuccess(userData: UserModel.UserData) {
        let data = UserModel.User(
            id: userData.id,
            name: userData.name,
            surname: userData.surname,
            email: userData.email,
            image: userData.image
        )
        
        viewModel.logInSuccess(userData: data)
    }

    func didLogInFailure(error: Error) {
        if let error = error as? LoginError {
            viewModel.showErrorMessage(error.localizedDescription)
        } else {
            viewModel.showErrorMessage(error.localizedDescription)
        }
    }
}
