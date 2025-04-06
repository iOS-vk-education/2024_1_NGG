//
//  EditPreferencesProtocols.swift
//  cinematch
//
//  Created by Ксения Панкратова on 10.01.2025.
//

import Foundation

protocol EditPreferencesDisplayLogic: EditPreferencesViewModelInput {
    var allGenres: [Genre] { get }
    var allDirectors: [Directors] { get }
}

protocol EditPreferencesViewModelInput {
    func setCoordinator(_ coordinator: NavigationControllerCoordinator)
    func toggleDirectorSelection(director: Directors)
    func toggleGenreSelection(genre: Genre)
    func didTapContinue()
    var anySelectionMade: Bool { get }
}
