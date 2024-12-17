//
//  SingUpViewModel+Mock.swift
//  animatch
//
//  Created by Ксения Панкратова on 14.12.2024.
//

#if DEBUG
import Foundation

final class SingUpViewModelMock: SingUpViewModelLogic {
    @Published var inputEmail = ""
    @Published var inputPasswordFirst = ""
    @Published var inputPasswordSecond = ""

    private(set) var users: [UserModel]

    init(users: [UserModel] = MockData.defaultUsers) {
        self.users = users
    }

    func didTapContinue(to screen: AppScreens) {
        coordinator?.addScreen(screen: screen)
    }

    @ObservationIgnored
    private var coordinator: Coordinator?

    func setCoordinator(_ coordinator: Coordinator) {
        self.coordinator = coordinator
    }
}

// MARK: - Mock Data -

private extension SingUpViewModelMock {
    enum MockData {
        static let defaultUsers: [UserModel] = [
            UserModel(id: 1, name: "Name", surname: "Surname", email: "1@example.com", password: "12345"),
            UserModel(id: 2, name: "Name2", surname: "Surname", email: "2@example.com", password: "qwerty"),
        ]
    }
}

#endif
