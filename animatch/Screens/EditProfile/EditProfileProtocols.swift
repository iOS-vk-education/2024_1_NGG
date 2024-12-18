//
//  EditProfileProtocols.swift
//  animatch
//
//  Created by Ксения Панкратова on 17.12.2024.
//

import Foundation

protocol EditProfileViewModelLogic: EditProfileViewModelInput {
    var inputName: String { get set }
    var inputSurname: String { get set }
    var inputEmail: String { get set }
}

protocol EditProfileViewModelInput {
    func setStartScreenViewModel(_ startScreenViewModel: StartScreenViewModel)
    func didTapSaveButton()
    func didTapDoLaterButton()
}
