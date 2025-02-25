//
//  MainEditProfileProtocols.swift
//  cinematch
//
//  Created by Ксения Панкратова on 23.12.2024.
//

import Foundation
import UIKit

protocol MainEditProfileDisplayLogic: MainEditProfileViewModelInput {
    var inputName: String { get set }
    var inputSurname: String { get set }
    var inputEmail: String { get set }
    var inputImage: UIImage? { get set }
}

protocol MainEditProfileViewModelInput {
    func didTapSaveButton()
    func setCoordinator(_ coordinator: Coordinator)
}
