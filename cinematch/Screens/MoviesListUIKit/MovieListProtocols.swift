//
//  MovieListProtocols.swift
//  cinematch
//
//  Created by Ксения Панкратова on 27.03.2025.
//

import Foundation

// MARK: - ViewModel

protocol MovieListDisplayData: AnyObject {
    var stories: [MovieCard] { get }
    var user: UserModel.User { get }
    var genres: [String] { get }
    var directors: [Int] { get }
    var uiProperties: UIProperties { get }
}

protocol MovieListViewModelInput: AnyObject {
    func setStartScreenViewModel(_ startScreenViewModel: StartScreenViewModel)
    func setCoordinator(_ coordinator: Coordinator)
    func loadMovies(completion: @escaping () -> Void)
}

protocol MovieListViewModelOutput: AnyObject {
    func configureDetailsViewModel(story: Module) -> DescriptionMovieDisplayLogic & DescriptionMovieViewModelOutput
    func didTapCell(story: MovieCard)
    func didTapProfile()
}

protocol MovieListDisplayLogic: AnyObject {
    func didFetchMovies(with movies: [MovieCard])
    func showErrorMessage(_ message: String)

    func didfetchMovieDescription(story: MovieDescription)
}

// MARK: - Interactor

protocol MovieListBusinessLogic {
    func getMovies(genres: [String], directors: [Int], page: Int) async
    func getDescriptionMovie(movieId: Int) async
}

// MARK: - Presenter

protocol MovieListPresenterInput {
    func didFetchMoviesSuccess(with movies: [MovieCard])
    func didFetchMoviesFailure(with error: Error)

    func didFetchMovieDescriptionSuccess(with movie: MovieDescription)
    func didFetchMovieDescriptionFailure(with error: Error)
}
