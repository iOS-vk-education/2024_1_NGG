//
//  LogInInteractor.swift
//  cinematch
//
//  Created by Ксения Панкратова on 16.03.2025.
//

final class LogInInteractor: LoginBusinessLogic {
    var presenter: PresenterInput?
    var worker: LoginAuthLogic?

    func logIn(email: String, password: String) async {
        do {
            try await worker?.makeAuth(email: email, password: password)
            presenter?.didLogInSuccess()
        } catch {
            presenter?.didLogInFailure(error: error)
        }
    }
}
