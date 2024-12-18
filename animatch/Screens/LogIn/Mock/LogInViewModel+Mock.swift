//
//  LogInViewModel+Mock.swift
//  animatch
//
//  Created by Ксения Панкратова on 13.12.2024.
//

#if DEBUG
import UIKit
import Foundation

@Observable
final class LogInViewModelMock: LogInViewModelLogic {
    var email: String = ""
    var password: String = ""

    private(set) var users: [UserModel]

    @ObservationIgnored
    private var startScreenViewModel: StartScreenViewModel?

    init(users: [UserModel] = MockData.defaultUsers) {
        self.users = users
    }
}

// MARK: - LogInViewModelInput

extension LogInViewModelMock {
    func didTapContinue() {
        startScreenViewModel?.updateScreen(newScreenState: .animeList)
    }

    func didTapOpenRegistrationScreen() {
        startScreenViewModel?.updateScreen(newScreenState: .signUp)
    }

    func validateData() -> Bool {
        users.contains { $0.email == email && $0.password == password }
    }

    func setStartScreenViewModel(_ startScreenViewModel: StartScreenViewModel) {
        self.startScreenViewModel = startScreenViewModel
    }
}

// MARK: - Mock Data -

private extension LogInViewModelMock {
    enum MockData {
        static let defaultUsers: [UserModel] = [
            UserModel(id: 1, name: "Name", surname: "Surname", email: "1@example.com", password: "12345"),
            UserModel(id: 2, name: "Name2", surname: "Surname", email: "2@example.com", password: "qwerty"),
            UserModel(id: 3, name: "Name3", surname: "Surname", email: "3", password: "3"),
        ]
    }
}
#endif
