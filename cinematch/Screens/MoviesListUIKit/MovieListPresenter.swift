//
//  MovieListPresenter.swift
//  cinematch
//
//  Created by Ксения Панкратова on 27.03.2025.
//

import Foundation

final class MovieListPresenter: MovieListPresenterInput {
    weak var viewModel: MovieListDisplayLogic!

    func didFetchMoviesSuccess(with movies: [MovieCard]) {
        viewModel?.didFetchMovies(with: movies)
    }

    func didFetchMoviesFailure(with error: any Error) {
        viewModel?.showErrorMessage(error.localizedDescription)
    }

    func didFetchMovieDescriptionSuccess(with movie: MovieDescription) {
        viewModel.didfetchMovieDescription(story: movie)
    }

    func didFetchMovieDescriptionFailure(with error: any Error) {
        viewModel?.showErrorMessage(error.localizedDescription)
    }
}
