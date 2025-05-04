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
    var genres: [String] { get }
    var directors: [Int] { get }
    var uiProperties: MovieListModel.UIProperties { get set }

    func configuration(at index: Int) -> FilmCell.Configuration?
}

protocol MovieListViewModelInput: AnyObject {
    func setStartScreenViewModel(_ startScreenViewModel: StartScreenViewModel)
    func setCoordinator(_ coordinator: Coordinator)
    func loadMovies(completion: @MainActor @escaping () -> Void)
}

protocol MovieListViewModelOutput: AnyObject {
    func configureDetailsViewModel(story: Module) -> DescriptionMovieDisplayLogic & DescriptionMovieViewModelOutput
    func didTapCell(story: MovieCard)
    func didTapProfile()
}

protocol MovieListDisplayLogic: AnyObject {
    func didFetchMovies(with movies: [MovieCard], totalPages: Int)
    func showErrorMessage(_ message: String)
}

// MARK: - Interactor

protocol MovieListBusinessLogic {
    func getMovies(genres: [String], directors: [Int], page: Int) async
}

// MARK: - Presenter

protocol MovieListPresenterInput {
    func didFetchMoviesSuccess(with movies: [MovieCard], totalPages: Int)
    func didFetchMoviesFailure(with error: Error)
}
