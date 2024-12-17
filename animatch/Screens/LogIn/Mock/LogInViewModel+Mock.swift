//
//  LogInViewModel+Mock.swift
//  animatch
//
//  Created by Ксения Панкратова on 13.12.2024.
//

#if DEBUG
import UIKit
import Foundation

final class LogInViewModelMock: LogInViewModelLogic {

    @Published var email: String = ""
    @Published var password: String = ""
    private(set) var users: [UserModel]

    init(users: [UserModel] = MockData.defaultUsers) {
        self.users = users
    }

    @ObservationIgnored
    private var coordinator: Coordinator?

    func setCoordinator(_ coordinator: Coordinator) {
        self.coordinator = coordinator
    }

    func didTapContinue(to screen: AppScreens) {
        coordinator?.addScreen(screen: screen)
    }

    func validateData() -> Bool {
        users.contains { $0.email == email && $0.password == password }
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
