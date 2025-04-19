//
//  MovieListViewModel.swift
//  cinematch
//
//  Created by Ксения Панкратова on 27.03.2025.
//

import Foundation

@Observable
final class MovieListViewModel: MovieListDisplayLogic {
    var interactor: MovieListBusinessLogic!

    private(set) var stories: [MovieCard]
    private(set) var user: UserModel.User
    private(set) var genres: [String] = ["драма","триллер"]
    private(set) var directors: [Int] = [2317924, 22260]
    private(set) var uiProperties = MovieListModel.UIProperties()

    @ObservationIgnored
    private var coordinator: Coordinator?
    @ObservationIgnored
    private var startScreenViewModel: StartScreenViewModel?

    init(
        stories: [MovieCard] = [],
        user: UserModel.User = MockData.user
    ) {
        self.stories = stories
        self.user = user
    }
}

extension MovieListViewModel: MovieListViewModelInput {
    func setStartScreenViewModel(_ startScreenViewModel: StartScreenViewModel) {
        self.startScreenViewModel = startScreenViewModel
    }
    
    func setCoordinator(_ coordinator: Coordinator) {
        self.coordinator = coordinator
    }

    func loadMovies(completion: @escaping () -> Void) {
        guard uiProperties.canLoadMorePages, !uiProperties.isLoadingMore else {
            completion()
            return
        }

        uiProperties.isLoadingMore = true

        Task {
            @MainActor in
            await interactor.getMovies(genres: genres, directors: directors, page: uiProperties.currentPage)
            uiProperties.currentPage += 1
            completion()
        }
    }
}

extension MovieListViewModel: MovieListViewModelOutput {
    func configureDetailsViewModel(story: Module) -> any DescriptionMovieDisplayLogic & DescriptionMovieViewModelOutput {
        let viewModel = DescriptionMovieViewModelMock(story: story)
        return viewModel
    }

    func didTapCell(story: MovieCard) {
        Task {
            await interactor.getDescriptionMovie(movieId: story.id)
        }
    }

    func didTapProfile() {
        coordinator?.addScreen(screen: MovieListScreens.profile)
    }
}

extension MovieListViewModel: MovieListDisplayData {
    func didFetchMovies(with movies: [MovieCard]) {
        if uiProperties.currentPage == 1 {
                stories = movies
            } else {
                stories += movies
            }

        uiProperties.canLoadMorePages = !movies.isEmpty
        uiProperties.isLoadingMore = false
    }

    func showErrorMessage(_ message: String) {
        print("[DEBUG]: \(message)")
    }

    func didfetchMovieDescription(story: MovieDescription) {
        // TODO: IOS-46: Получение подробной информации по фильму
    }
}

// MARK: - MockData

private extension MovieListViewModel {
    enum MockData {
        static let user = UserModel.User( name: "Name", surname: "Surname", email: "1@example.com", image: nil)
    }
}
