//
//  ChoiceGenresProtocols.swift
//  cinematch
//
//  Created by Ксения Панкратова on 22.12.2024.
//

import Foundation

protocol ChoiceGenresDisplayLogic: ChoiceGenresViewModelInput {
    var genres: [Genre] { get }
    var anyGenreSelected: Bool { get }
    var uiProperties: ChoiceGenresModel.UIProperties { get set }

    func toggleGenreSelection(genre: Genre)
}

protocol ChoiceGenresViewModelInput {
    func setCoordinator(_ coordinator: Coordinator)
    func setStartScreenViewModel(_ startScreenViewModel: StartScreenViewModel)
    func didTapContinue()
    func fetchGenres()
}
