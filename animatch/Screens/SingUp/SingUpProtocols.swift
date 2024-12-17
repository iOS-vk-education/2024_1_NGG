//
//  SingUpProtocols.swift
//  animatch
//
//  Created by Ксения Панкратова on 17.12.2024.
//

import Foundation

protocol SingUpViewModelLogic: SingUpViewModelInput {
    var inputEmail: String { get set }
    var inputPasswordFirst: String { get set }
    var inputPasswordSecond: String { get set }

    var users: [UserModel] { get }
}

protocol SingUpViewModelInput {
    func setCoordinator(_ coordinator: Coordinator)
    func didTapContinue(to screen: AppScreens)
}
