//
//  EditProfileProtocols.swift
//  cinematch
//
//  Created by Ксения Панкратова on 17.12.2024.
//

import Foundation
import UIKit

protocol EditProfileDisplayLogic: EditProfileViewModelInput {
    var inputName: String { get set }
    var inputSurname: String { get set }
    var inputEmail: String { get set }
    var inputImage: UIImage? { get set }
}

protocol EditProfileViewModelInput {
    func setStartScreenViewModel(_ startScreenViewModel: StartScreenViewModel)
    func didTapSaveButton()
    func didTapDoLaterButton()
}
