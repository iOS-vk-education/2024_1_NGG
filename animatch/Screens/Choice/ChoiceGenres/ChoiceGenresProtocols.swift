//
//  ChoiceGenresProtocols.swift
//  animatch
//
//  Created by Ксения Панкратова on 22.12.2024.
//

import Foundation

protocol ChoiceGenresDisplayLogic: ChoiceGenresViewModelInput {
    var genres: [Genre] { get }

    func toggleGenreSelection(genre: Genre)
    var anyGenreSelected: Bool { get }
}

protocol ChoiceGenresViewModelInput {
    func setCoordinator(_ coordinator: Coordinator)
    func setStartScreenViewModel(_ startScreenViewModel: StartScreenViewModel)
    func didTapContinue()
}
