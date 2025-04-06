//
//  MovieListViewModel.swift
//  cinematch
//
//  Created by Ксения Панкратова on 27.03.2025.
//

import Foundation

final class MovieListViewModel: MovieListDisplayLogic {
    var interactor: MovieListBusinessLogic!

    private(set) var stories: [Module]
    private(set) var showLoading: Bool
    private(set) var user: UserModel.User

    private var coordinator: NavigationControllerCoordinator?

    init(
        stories: [Module] = [],
        showLoading: Bool = false,
        user: UserModel.User = MockData.user
    ) {
        self.stories = stories
        self.showLoading = showLoading
        self.user = user
    }
}

extension MovieListViewModel: MovieListViewModelInput {
    func setCoordinator(_ coordinator: NavigationControllerCoordinator) {
        self.coordinator = coordinator
    }

    func onAppear(completion: @escaping () -> Void) {
        showLoading = true

        Task {
            await interactor.getMovies()
            completion()
        }
    }
}

extension MovieListViewModel: MovieListViewModelOutput {
    func configureDetailsViewModel(story: Module) -> any DescriptionMovieDisplayLogic & DescriptionMovieViewModelOutput {
        let viewModel = DescriptionMovieViewModelMock(story: story)
        return viewModel
    }

    func didTapCell(story: Module) {
        coordinator?.addScreen(screen: MovieListScreens.storyDetails(story))
    }

    func didTapProfile() {
        coordinator?.addScreen(screen: MovieListScreens.profile)
    }
}

extension MovieListViewModel: MovieListDisplayData {
    func didFetchMovies(with movies: [Module]) {
        stories = movies
        showLoading = false
    }

    func showErrorMessage(_ message: String) {
        showLoading = false
        print("[DEBUG]: \(message)")
    }
}

// MARK: - MockData

private extension MovieListViewModel {
    enum MockData {
        static let user = UserModel.User( name: "Name", surname: "Surname", email: "1@example.com", image: nil)
    }
}
