//
//  MovieListViewModel.swift
//  cinematch
//
//  Created by Ксения Панкратова on 27.03.2025.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

@Observable
final class MovieListViewModel: MovieListDisplayLogic {
    var interactor: MovieListBusinessLogic!

    private(set) var stories: [MovieCard]
    private(set) var genres: [String] = []
    private(set) var directors: [Int] = []
    private(set) var uiProperties = MovieListModel.UIProperties()

    @ObservationIgnored
    private var coordinator: Coordinator?
    @ObservationIgnored
    private var startScreenViewModel: StartScreenViewModel?

    init(
        stories: [MovieCard] = []
    ) {
        self.stories = stories
    }

    func configuration(at index: Int) -> FilmCell.Configuration? {
        let story = stories[index]
        return FilmCell.Configuration(
            title: story.title,
            genre: story.genre,
            type: story.type,
            year: "\(story.year)",
            image: UIImage(data: story.mainImage)
        )
    }
}

extension MovieListViewModel: MovieListViewModelInput {
    func setStartScreenViewModel(_ startScreenViewModel: StartScreenViewModel) {
        self.startScreenViewModel = startScreenViewModel
    }

    func setCoordinator(_ coordinator: Coordinator) {
        self.coordinator = coordinator
    }

    func loadMovies(completion: @MainActor @escaping () -> Void) {
        guard uiProperties.canLoadMorePages, !uiProperties.isLoadingMore else {
            Task { @MainActor in
                completion()
            }
            return
        }

        uiProperties.isLoadingMore = true

        Task {
            await interactor.getMovies(genres: genres, directors: directors, page: uiProperties.currentPage)
            await MainActor.run {
                uiProperties.currentPage += 1
                completion()
            }
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
