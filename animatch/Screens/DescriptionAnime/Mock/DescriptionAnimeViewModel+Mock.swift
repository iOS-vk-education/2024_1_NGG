//
//  DescriptionAnimeViewModel+Mock.swift
//  animatch
//
//  Created by Ксения Панкратова on 03.12.2024.
//

import Foundation

#if DEBUG

@Observable
final class DescriptionAnimeViewModelMock: DescriptionAnimeDisplayLogic & DescriptionAnimeViewModelOutput {
    private(set) var story: Module

    @ObservationIgnored
    private var coordinator: Coordinator?

    @ObservationIgnored
    private var startScreenViewModel: StartScreenViewModel?

    init(story: Module) {
        self.story = story
    }
}

extension DescriptionAnimeViewModelMock {

    func setCoordinator(_ coordinator: Coordinator) {
        self.coordinator = coordinator
    }

    func didTapOpenSimilarStory(movie: Module) {
        coordinator?.addScreen(screen: AnimeListScreens.storyDetails(movie))
    }

    func configureDetailsViewModel(story: Module) -> any DescriptionAnimeDisplayLogic & DescriptionAnimeViewModelOutput {
        let viewModel = DescriptionAnimeViewModelMock(story: story)
        return viewModel
    }

    func setStartScreenViewModel(_ startScreenViewModel: StartScreenViewModel) {
        self.startScreenViewModel = startScreenViewModel
    }
}

#endif
