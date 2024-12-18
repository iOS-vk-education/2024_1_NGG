//
//  SingUpViewModel+Mock.swift
//  animatch
//
//  Created by Ксения Панкратова on 14.12.2024.
//

#if DEBUG

import Foundation

final class SingUpViewModelMock: SingUpViewModelLogic {
    var inputEmail = ""
    var inputPasswordFirst = ""
    var inputPasswordSecond = ""
    
    private(set) var users: [UserModel]
    
    @ObservationIgnored
    private var startScreenViewModel: StartScreenViewModel?
    
    init(users: [UserModel] = MockData.defaultUsers) {
        self.users = users
    }
    
    func setStartScreenViewModel(_ startScreenViewModel: StartScreenViewModel) {
        self.startScreenViewModel = startScreenViewModel
    }
    
    func didTapContinue() {
        startScreenViewModel?.updateScreen(newScreenState: .editProfile)
    }
    
    func didTapOpenSignInScreen() {
        startScreenViewModel?.updateScreen(newScreenState: .signIn)
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
