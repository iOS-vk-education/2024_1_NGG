//
//  SignUpProtocols.swift
//  cinematch
//
//  Created by Ксения Панкратова on 17.12.2024.
//

import Foundation

protocol SignUpViewModelLogic: SignUpViewModelInput {
    var inputEmail: String { get set }
    var inputPasswordFirst: String { get set }
    var inputPasswordSecond: String { get set }
}

protocol SignUpViewModelInput {
    func setStartScreenViewModel(_ startScreenViewModel: StartScreenViewModel)
    func didTapContinue()
    func didTapOpenSignInScreen()
}
