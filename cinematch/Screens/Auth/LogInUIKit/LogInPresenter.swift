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
        let data = processingData(userData: userData)
        viewModel.logInSuccess(userData: data)
    }

    func didLogInFailure(error: Error) {
        if let error = error as? LoginError {
            viewModel.showErrorMessage(error.localizedDescription)
        } else {
            viewModel.showErrorMessage(error.localizedDescription)
        }
    }

    func processingData(userData: UserModel.UserData) -> UserModel.User {
        var imageData = UIImage.totoro1.jpegData(compressionQuality: 2)

        return UserModel.User(
            name: userData.name,
            surname: userData.surname,
            email: userData.email,
            password: userData.password,
            image: imageData
        )
    }
}
