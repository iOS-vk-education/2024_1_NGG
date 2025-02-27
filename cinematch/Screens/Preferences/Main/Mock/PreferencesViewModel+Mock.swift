//
//  PreferencesViewModel+Mock.swift
//  cinematch
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
            ) ?? MockData.defaultDirectors
        genres = UserDefaults.standard
            .stringArray(
                forKey: Constants.selectedGenresKey
            ) ?? MockData.defaultGenres
    }
}

// MARK: - PreferencesViewModelInput

extension PreferencesViewModelMock {

    func setCoordinator(_ coordinator: Coordinator) {
        self.coordinator = coordinator
    }

    func didTapEdit() {
        coordinator?.addScreen(screen: MovieListScreens.editPreferences)
    }

    func reloadData() {
        genres = UserDefaults.standard.stringArray(forKey: Constants.selectedGenresKey) ?? MockData.defaultGenres
        directors = UserDefaults.standard.stringArray(forKey: Constants.selectedDirectorsKey) ?? MockData.defaultDirectors
    }
}

// MARK: - Constants

private extension PreferencesViewModelMock {
    enum Constants {
        static let selectedDirectorsKey = "selectedDirectors"
        static let selectedGenresKey = "selectedGenres"
    }

    enum MockData {
        static let defaultDirectors = [
            "Макото Синкай",
            "Мари Окада",
            "Тэцуро Араки",
            "Хаяо Миядзаки",
            "Сатоси Кон",
            "Осаму Тэдзука",
            "Кацухиро Отомо",
            "Мамору Оси",
            "Синъитиро Ватанабэ"
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
}

#endif
