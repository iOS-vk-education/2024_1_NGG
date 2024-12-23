//
//  ChoiceDirectorsViewModel+Mock.swift
//  animatch
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
        }
    }

    func didTapContinue() {
        startScreenViewModel?.updateScreen(newScreenState: .animeList)
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
}

// MARK: - Constants

private extension ChoiceDirectorsViewModelMock {
    enum MockData {
        static let defaultDirectors = [
            "Макото Синкай",
            "Мари Окада",
            "Тэцуро Араки",
            "Хаяо Миядзаки",
            "Сатоси Кон"
        ]
    }
}

#endif
