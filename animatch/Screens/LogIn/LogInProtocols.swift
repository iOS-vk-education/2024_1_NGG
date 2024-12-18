//
//  LogInProtocols.swift
//  animatch
//
//  Created by Ксения Панкратова on 16.12.2024.
//

import Foundation

protocol LogInViewModelLogic: LogInViewModelInput {
    var email: String { get set }
    var password: String { get set }
    var users: [UserModel] { get }
    
    func validateData() -> Bool
    
}

protocol LogInViewModelInput {
    func setStartScreenViewModel(_ startScreenViewModel: StartScreenViewModel)
    func didTapContinue()
    func didTapOpenRegistrationScreen()
}
