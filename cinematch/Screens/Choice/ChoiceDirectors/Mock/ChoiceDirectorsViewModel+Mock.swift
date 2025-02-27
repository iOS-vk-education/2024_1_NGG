//
//  ChoiceDirectorsViewModel+Mock.swift
//  cinematch
//
//  Created by Ксения Панкратова on 22.12.2024.
//

#if DEBUG

import Foundation
import SwiftUI

@Observable
final class ChoiceDirectorsViewModelMock: ChoiceDirectorsViewModelLogic {
    var directors: [Directors] = []

    @ObservationIgnored
    private var startScreenViewModel: StartScreenViewModel?
    @ObservationIgnored
    private var coordinator: Coordinator?

    init() {
        directors = MockData.defaultDirectors.map {
            Directors(name: $0, isSelected: false)
        }
    }
}

// MARK: - ChoiceDirectorsViewModelInput

extension ChoiceDirectorsViewModelMock {

    func toggleDirectorSelection(director: Directors) {
        if let index = directors.firstIndex(where: { $0.name == director.name }) {
            directors[index].isSelected.toggle()

            var savedDirectors = UserDefaults.standard.stringArray(forKey: "selectedDirectors") ?? []

            if directors[index].isSelected {
                savedDirectors.append(directors[index].name)
            } else {
                savedDirectors.removeAll { $0 == directors[index].name }
            }
            UserDefaults.standard.set(savedDirectors, forKey: "selectedDirectors")
        }
    }

    func didTapContinue() {
        startScreenViewModel?.updateScreen(newScreenState: .movieList)
        if let state = startScreenViewModel?.currentScreenState {
            UserDefaults.standard.set(state.rawValue, forKey: "State")
        }
    }

    func setCoordinator(_ coordinator: Coordinator) {
        self.coordinator = coordinator
    }

    func setStartScreenViewModel(_ startScreenViewModel: StartScreenViewModel) {
        self.startScreenViewModel = startScreenViewModel
    }

    var anyDirectorSelected: Bool {
        directors.contains { $0.isSelected }
    }
}

// MARK: - Constants

private extension ChoiceDirectorsViewModelMock {
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
    }
}

#endif
