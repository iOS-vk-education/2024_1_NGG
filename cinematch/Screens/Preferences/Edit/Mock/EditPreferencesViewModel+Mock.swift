//
//  EditPreferencesViewModel+Mock.swift
//  cinematch
//
//  Created by Ксения Панкратова on 10.01.2025.
//

#if DEBUG

import Foundation

@Observable
final class EditPreferencesViewModelMock: EditPreferencesDisplayLogic {

    private(set) var allDirectors: [Directors] = []
    private(set) var allGenres: [Genre] = []
    @ObservationIgnored
    private var coordinator: NavigationControllerCoordinator?

    init() {
        allGenres = MockData.defaultGenres.map {
            Genre(name: $0, isSelected: false)
        }
        allDirectors = MockData.defaultDirectors.map {
            Directors(name: $0, isSelected: false)
        }
    }
}

// MARK: - PreferencesViewModelInput

extension EditPreferencesViewModelMock {

    func setCoordinator(_ coordinator: NavigationControllerCoordinator) {
        self.coordinator = coordinator
    }

    func toggleDirectorSelection(director: Directors) {
        if let index = allDirectors.firstIndex(where: { $0.name == director.name }) {
            allDirectors[index].isSelected.toggle()
        }
    }

    func toggleGenreSelection(genre: Genre) {
        if let index = allGenres.firstIndex(where: { $0.name == genre.name }) {
            allGenres[index].isSelected.toggle()
        }
    }

    func didTapContinue() {
        UserDefaults.standard.removeObject(forKey: Constants.selectedGenresKey)
        UserDefaults.standard.removeObject(forKey: Constants.selectedDirectorsKey)

        let selectedDirectors = allDirectors
            .filter { $0.isSelected }
            .map { $0.name }
        UserDefaults.standard.set(selectedDirectors, forKey: Constants.selectedDirectorsKey)

        let selectedGenres = allGenres
            .filter { $0.isSelected }
            .map { $0.name }
        UserDefaults.standard.set(selectedGenres, forKey: Constants.selectedGenresKey)

        coordinator?.openPreviousScreen()
    }

    var anySelectionMade: Bool {
        allGenres.contains { $0.isSelected } && allDirectors.contains { $0.isSelected }
    }
}

private extension EditPreferencesViewModelMock {

    // MARK: - MockData

    enum MockData {
        static let defaultDirectors = [
            "Макото Синкай",
            "Мари Окада",
            "Тэцуро Араки",
            "Хаяо Миядзаки",
            "Сатоси Кон"
        ]
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

    // MARK: - Constants

    enum Constants {
        static let selectedDirectorsKey = "selectedDirectors"
        static let selectedGenresKey = "selectedGenres"
    }
}

#endif
