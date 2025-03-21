//
//  LogInProtocols.swift
//  cinematch
//
//  Created by Ксения Панкратова on 16.03.2025.
//

import Foundation

// MARK: - ViewModel

protocol LoginDisplayData: AnyObject {
    var email: String { get set }
    var password: String { get set }

    var uiProperties: UserModel.UIProperties { get set }
    // почему тут get set
    var receiveUserData: UserModel.User { get set }
}

protocol LoginViewModelInput: AnyObject {
    func didTapLogInButton()
    func didTapOpenRegistrationScreen()
    func setStartScreenViewModel(_ startScreenViewModel: StartScreenViewModel)
}

protocol LoginViewModelDisplayLogic: AnyObject {
    func logInSuccess(userData: UserModel.User)
    func showErrorMessage(_ message: String)
}

// MARK: - Interactor

protocol LoginBusinessLogic: AnyObject {
    func logIn(email: String, password: String)
}

// MARK: - Worker

protocol LoginAuthLogic {
    func makeAuth(email: String, password: String) async throws -> UserModel.UserData
}

// MARK: - Presenter

protocol PresenterInput {
    func didLogInSuccess(userData: UserModel.UserData)
    func didLogInFailure(error: Error)
}
