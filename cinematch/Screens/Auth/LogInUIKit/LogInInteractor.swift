//
//  LogInInteractor.swift
//  cinematch
//
//  Created by Ксения Панкратова on 16.03.2025.
//

final class LogInInteractor: LoginBusinessLogic {
    var presenter: PresenterInput?
    var worker: LoginAuthLogic

    init(worker: LoginAuthLogic) {
        self.worker = worker
    }

    func logIn(email: String, password: String) {
        Task {
            do {
                let doc = try await worker.makeAuth(email: email, password: password)
                await MainActor.run {
                    presenter?.didLogInSuccess(userData: doc)
                    print(doc)
                }
            } catch {
                await MainActor.run {
                    presenter?.didLogInFailure(error: error)
                }
            }
        }
    }
}
