//
//  ChoiceGenresProtocols.swift
//  animatch
//
//  Created by Ксения Панкратова on 22.12.2024.
//

import Foundation

protocol ChoiceGenresViewModelLogic: ChoiceGenresViewModelInput {
    var genres: [Genre] { get }

    func toggleGenreSelection(genre: Genre)
}

protocol ChoiceGenresViewModelInput {
    func setCoordinator(_ coordinator: Coordinator)
    func setStartScreenViewModel(_ startScreenViewModel: StartScreenViewModel)
    func didTapContinue()
}
