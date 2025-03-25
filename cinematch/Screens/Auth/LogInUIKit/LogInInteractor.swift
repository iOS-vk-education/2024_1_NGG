//
//  LogInInteractor.swift
//  cinematch
//
//  Created by Ксения Панкратова on 16.03.2025.
//

import FirebaseAuth

final class LogInInteractor: LoginBusinessLogic {
    var presenter: PresenterInput?
    var worker: LoginAuthLogic

    init(worker: LoginAuthLogic) {
        self.worker = worker
    }

    func logIn(email: String, password: String) {
        Task {
            do {
                let authResult = try await worker.makeAuth(email: email, password: password)
                await getUserData(authResult: authResult)
            } catch {
                await MainActor.run {
                    presenter?.didLogInFailure(error: error)
                }
            }
        }
    }

    func getUserData(authResult: AuthDataResult) async {
        do {
            let userData = try await worker.fetchUserData(authResult: authResult)

            let savedUserModel = SavedUserModel(
                id: userData.id,
                name: userData.name,
                surname: userData.surname,
                email: userData.email,
                imageState: .loading(url: userData.image)
            )

            await MainActor.run {
                presenter?.didLogInSuccess(userData: savedUserModel)
            }
        } catch {
            await MainActor.run {
                presenter?.didLogInFailure(error: error)
            }
        }
    }
}
