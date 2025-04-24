//
//  LogInProtocols.swift
//  cinematch
//
//  Created by Ксения Панкратова on 16.03.2025.
//

import Foundation
import FirebaseAuth

// MARK: - ViewModel

protocol LoginDisplayData: AnyObject {
    var uiProperties: UserModel.UIProperties { get set }
    var showAlert: Bool { get set }
    var errorMessage: String { get set }
    var isLoading: Bool { get }
}

protocol LoginViewModelInput: AnyObject {
    func didTapLogInButton()
    func didTapOpenRegistrationScreen()
    func setStartScreenViewModel(_ startScreenViewModel: StartScreenViewModel)
}

protocol LoginViewModelDisplayLogic: AnyObject {
    func logInSuccess()
    func showErrorMessage(_ message: String)
}

// MARK: - Interactor

protocol LoginBusinessLogic: AnyObject {
    func logIn(email: String, password: String)
}

// MARK: - Worker

protocol LoginAuthLogic {
    func makeAuth(email: String, password: String) async throws
}

// MARK: - Presenter

protocol PresenterInput {
    func didLogInSuccess()
    func didLogInFailure(error: Error)
}
