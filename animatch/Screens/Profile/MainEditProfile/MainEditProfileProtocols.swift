//
//  MainEditProfileProtocols.swift
//  animatch
//
//  Created by Ксения Панкратова on 23.12.2024.
//

import Foundation

protocol MainEditProfileViewModelLogic: MainEditProfileViewModelInput {
    var inputName: String { get set }
    var inputSurname: String { get set }
    var inputEmail: String { get set }
}

protocol MainEditProfileViewModelInput {
    func didTapSaveButton()
    func setCoordinator(_ coordinator: Coordinator)
}
