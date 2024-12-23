//
//  MainProfileViewModel+Mock.swift
//  animatch
//
//  Created by Ксения Панкратова on 23.12.2024.
//

#if DEBUG

import UIKit
import Foundation

@Observable
final class MainProfileViewModelMock: MainProfileDisplayLogic & MainProfileViewModelOutput {
    @ObservationIgnored
    var delay: TimeInterval

    private(set) var stories: [Module]
    private(set) var showLoading: Bool
    private(set) var user: UserModel

    @ObservationIgnored
    private var coordinator: Coordinator?
    @ObservationIgnored
    private var startScreenViewModel: StartScreenViewModel?

    init(
        delay: TimeInterval = 0,
        stories: [Module] = MockData.stories,
        showLoading: Bool = false,
        user: UserModel = MockData.user

    ) {
        self.delay = delay
        self.stories = stories
        self.showLoading = showLoading
        self.user = user
    }
}

extension MainProfileViewModelMock {

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

    func setCoordinator(_ coordinator: Coordinator) {
        self.coordinator = coordinator
    }

    func setStartScreenViewModel(_ startScreenViewModel: StartScreenViewModel) {
        self.startScreenViewModel = startScreenViewModel
    }

    func didTapCell(story: Module) {
        coordinator?.addScreen(screen: AnimeListScreens.storyDetails(story))
    }

    func didTapEdit() {
        coordinator?.addScreen(screen: AnimeListScreens.edit)
    }

    func logout() {
        startScreenViewModel?.updateScreen(newScreenState: .initial)
        UserDefaults.standard.set(StartScreenState.initial.rawValue, forKey: "State")
    }

    func configureDetailsViewModel(story: Module) -> DescriptionAnimeDisplayLogic & DescriptionAnimeViewModelOutput {
        let viewModel = DescriptionAnimeViewModelMock(story: story)
        return viewModel
    }
}

// MARK: - Mock Data -

private extension MainProfileViewModelMock {

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

        static let user = UserModel(id: 1, name: "Name", surname: "Surname", email: "1@example.com", password: "12345")
    }
}

#endif
