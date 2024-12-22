//
//  ChoiceGenresViewModel+Mock.swift
//  animatch
//
//  Created by Ксения Панкратова on 22.12.2024.
//

import Foundation
import SwiftUI

@Observable
final class ChoiceGenresViewModelMock: ChoiceGenresViewModelLogic {
    var genres: [Genre] = []

    @ObservationIgnored
    private var startScreenViewModel: StartScreenViewModel?

    init() {
        genres = MockData.defaultGenres.map {
            Genre(name: $0, isSelected: false)
        }
    }

    func toggleGenreSelection(genre: Genre) {
        if let index = genres.firstIndex(where: { $0.name == genre.name }) {
            genres[index].isSelected.toggle()
        }
    }

    func setStartScreenViewModel(_ startScreenViewModel: StartScreenViewModel) {
        self.startScreenViewModel = startScreenViewModel
    }

    func didTapContinue() {
        startScreenViewModel?.updateScreen(newScreenState: .choiceDirectors)
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
