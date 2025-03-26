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
    var receiveUserData: SavedUserModel? { get set }
}

protocol LoginViewModelInput: AnyObject {
    func didTapLogInButton()
    func didTapOpenRegistrationScreen()
    func setStartScreenViewModel(_ startScreenViewModel: StartScreenViewModel)
}

protocol LoginViewModelDisplayLogic: AnyObject {
    func logInSuccess(userData: SavedUserModel)
    func showErrorMessage(_ message: String)
}

// MARK: - Interactor

protocol LoginBusinessLogic: AnyObject {
    func logIn(email: String, password: String)
    func getUserData(authResult: AuthDataResult) async
}

// MARK: - Worker

protocol LoginAuthLogic {
    func makeAuth(email: String, password: String) async throws -> AuthDataResult
    func fetchUserData(authResult: AuthDataResult) async throws -> UserModel.UserData
}

// MARK: - Presenter

protocol PresenterInput {
    func didLogInSuccess(userData: SavedUserModel)
    func didLogInFailure(error: Error)
}
