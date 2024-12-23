//
//  ChoiceDirectorsProtocols.swift
//  animatch
//
//  Created by Ксения Панкратова on 22.12.2024.
//

import Foundation

protocol ChoiceDirectorsViewModelLogic: ChoiceDirectorsViewModelInput {
    var directors: [Directors] { get }

    func toggleDirectorSelection(director: Directors)
}

protocol ChoiceDirectorsViewModelInput {
    func setCoordinator(_ coordinator: Coordinator)
    func setStartScreenViewModel(_ startScreenViewModel: StartScreenViewModel)
    func didTapContinue()
}
