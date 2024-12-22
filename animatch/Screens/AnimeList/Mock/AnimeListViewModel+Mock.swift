//
//  AnimeListViewModel+Mock.swift
//  animatch
//
//  Created by Ксения Панкратова on 27.11.2024.
//

#if DEBUG

import UIKit
import Foundation

@Observable
final class AnimeListViewModelMock: AnimeListDisplayLogic & AnimeListViewModelOutput {
    @ObservationIgnored
    var delay: TimeInterval

    private(set) var stories: [Module]
    private(set) var showLoading: Bool

    @ObservationIgnored
    private var coordinator: Coordinator?
    @ObservationIgnored
    private var startScreenViewModel: StartScreenViewModel?

    init(
        delay: TimeInterval = 0,
        stories: [Module] = [],
        showLoading: Bool = false

    ) {
        self.delay = delay
        self.stories = stories
        self.showLoading = showLoading
    }
}

extension AnimeListViewModelMock {

    func onAppear() {
        showLoading = true

        Task {
            try? await Task.sleep(for: .seconds(delay))
            await MainActor.run {
                stories = MockData.stories
                showLoading = false
            }
        }
    }

    func setStartScreenViewModel(_ startScreenViewModel: StartScreenViewModel) {
        self.startScreenViewModel = startScreenViewModel
    }

    func setCoordinator(_ coordinator: Coordinator) {
        self.coordinator = coordinator
    }

    func didTapCell(story: Module) {
        coordinator?.addScreen(screen: AnimeListScreens.storyDetails(story))
    }

    func logOut() {
        startScreenViewModel?.updateScreen(newScreenState: .singUpButExit)
        UserDefaults.standard.set(StartScreenState.singUpButExit.rawValue, forKey: "State")
    }

    func configureDetailsViewModel(story: Module) -> DescriptionAnimeDisplayLogic & DescriptionAnimeViewModelOutput {
        let viewModel = DescriptionAnimeViewModelMock(story: story)
        return viewModel
    }
}

// MARK: - Mock Data -

private extension AnimeListViewModelMock {

    enum MockData {
        static let stories = (1...5).map {
            let tempStory = Module.generateStory(number: $0)
            let similarMovies = ($0...$0 + 3).map { Module.generateStory(number: $0) }

            return Module(
                id: tempStory.id,
                mainImage: tempStory.mainImage,
                title: tempStory.title,
                director: tempStory.director,
                description: tempStory.description,
                rating: tempStory.rating,
                type: tempStory.type,
                year: tempStory.year,
                genre: tempStory.genre,
                imagesData: tempStory.imagesData,
                similarMovies: similarMovies,
                viewingPlatforms: tempStory.viewingPlatforms
            )
        }
    }
}

#endif
