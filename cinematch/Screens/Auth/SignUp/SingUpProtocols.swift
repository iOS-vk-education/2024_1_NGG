//
//  SignUpProtocols.swift
//  cinematch
//
//  Created by Ксения Панкратова on 17.12.2024.
//

import Foundation

protocol SignUpDisplayData {
    var inputData: InputData { get set }
    var uiProperties: SignUpModel.UIProperties { get set }
}

protocol SignUpViewModelInput {
    func setStartScreenViewModel(_ startScreenViewModel: StartScreenViewModel)
    func didTapContinue()
    func didTapOpenSignInScreen()
}
