//
//  PreferencesViewModel+Mock.swift
//  animatch
//
//  Created by Ксения Панкратова on 04.01.2025.
//

#if DEBUG

import Foundation

@Observable
final class PreferencesViewModelMock: PreferencesDisplayLogic {

    private(set) var directors: [String]
    private(set) var genres: [String]
    @ObservationIgnored
    private var coordinator: Coordinator?

    init() {
        directors = UserDefaults.standard
            .stringArray(
                forKey: Constants.selectedDirectorsKey
            ) ?? []
        genres = UserDefaults.standard
            .stringArray(
                forKey: Constants.selectedGenresKey
            ) ?? []
    }
}

// MARK: - PreferencesViewModelInput

extension PreferencesViewModelMock {

    func setCoordinator(_ coordinator: Coordinator) {
        self.coordinator = coordinator
    }

    func didTapEdit() {
        coordinator?.addScreen(screen: AnimeListScreens.editPreferences)
    }

    func reloadData() {
        genres = UserDefaults.standard.stringArray(forKey: Constants.selectedGenresKey) ?? []
        directors = UserDefaults.standard.stringArray(forKey: Constants.selectedDirectorsKey) ?? []
    }
}

// MARK: - Constants

private extension PreferencesViewModelMock {
    enum Constants {
        static let selectedDirectorsKey = "selectedDirectors"
        static let selectedGenresKey = "selectedGenres"
    }
}

#endif
