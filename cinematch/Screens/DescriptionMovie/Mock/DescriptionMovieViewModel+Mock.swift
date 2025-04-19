//
//  DescriptionMovieViewModel+Mock.swift
//  cinematch
//
//  Created by Ксения Панкратова on 03.12.2024.
//

import Foundation

#if DEBUG

@Observable
final class DescriptionMovieViewModelMock: DescriptionMovieDisplayLogic & DescriptionMovieViewModelOutput {
    private(set) var story: Module

    @ObservationIgnored
    private var coordinator: Coordinator?

    @ObservationIgnored
    private var startScreenViewModel: StartScreenViewModel?

    init(story: Module) {
        self.story = story
    }
}

extension DescriptionMovieViewModelMock {
    func setCoordinator(_ coordinator: Coordinator) {
        self.coordinator = coordinator
    }

    func didTapOpenSimilarStory(movie: Module) {
//        coordinator?.addScreen(screen: MovieListScreens.storyDetails(movie))
    }

    func configureDetailsViewModel(story: Module) -> any DescriptionMovieDisplayLogic & DescriptionMovieViewModelOutput {
        let viewModel = DescriptionMovieViewModelMock(story: story)
        return viewModel
    }

    func setStartScreenViewModel(_ startScreenViewModel: StartScreenViewModel) {
        self.startScreenViewModel = startScreenViewModel
    }
}

#endif
