//
//  EditPreferencesProtocols.swift
//  animatch
//
//  Created by Ксения Панкратова on 10.01.2025.
//

import Foundation

protocol EditPreferencesDisplayLogic: EditPreferencesViewModelInput {
    var allGenres: [Genre] { get }
    var allDirectors: [Directors] { get }
}

protocol EditPreferencesViewModelInput {
    func setCoordinator(_ coordinator: Coordinator)
    func toggleDirectorSelection(director: Directors)
    func toggleGenreSelection(genre: Genre)
    func didTapContinue()
}
