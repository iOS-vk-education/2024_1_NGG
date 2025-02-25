//
//  ChoiceGenresViewModel+Mock.swift
//  cinematch
//
//  Created by Ксения Панкратова on 22.12.2024.
//

import Foundation
import SwiftUI

@Observable
final class ChoiceGenresViewModelMock: ChoiceGenresDisplayLogic {
    var genres: [Genre] = []

    @ObservationIgnored
    private var coordinator: Coordinator?
    @ObservationIgnored
    private var startScreenViewModel: StartScreenViewModel?

    init() {
        genres = MockData.defaultGenres.map {
            Genre(name: $0, isSelected: false)
        }
    }
}

// MARK: - ChoiceDirectorsViewModelInput

extension ChoiceGenresViewModelMock {

    func toggleGenreSelection(genre: Genre) {
        if let index = genres.firstIndex(where: { $0.name == genre.name }) {
            genres[index].isSelected.toggle()

            var savedGenres = UserDefaults.standard.stringArray(forKey: "selectedGenres") ?? []

            if genres[index].isSelected {
                savedGenres.append(genres[index].name)
            } else {
                savedGenres.removeAll { $0 == genres[index].name }
            }
            UserDefaults.standard.set(savedGenres, forKey: "selectedGenres")
        }
    }

    func setStartScreenViewModel(_ startScreenViewModel: StartScreenViewModel) {
        self.startScreenViewModel = startScreenViewModel
    }

    func setCoordinator(_ coordinator: Coordinator) {
        self.coordinator = coordinator
    }

    func didTapContinue() {
        coordinator?.addScreen(screen: PreferenceScreens.directors)
        UserDefaults.standard.removeObject(forKey: "selectedDirectors")
    }
    
    var anyGenreSelected: Bool {
        genres.contains { $0.isSelected }
    }
}

// MARK: - Constants

private extension ChoiceGenresViewModelMock {
    enum MockData {
        static let defaultGenres = [
            "Семейный",
            "Приключения",
            "Комедия",
            "Драма",
            "Фантастика",
            "Ужасы",
            "Триллер",
            "Детектив",
            "Психологический триллер"
        ]
    }
}
