//
//  MovieListPresenter.swift
//  cinematch
//
//  Created by Ксения Панкратова on 27.03.2025.
//

import Foundation

final class MovieListPresenter: MovieListPresenterInput {
    weak var viewModel: MovieListDisplayLogic!

    func didFetchMoviesSuccess(with movies: [MovieCard], totalPages: Int) {
        viewModel?.didFetchMovies(with: movies, totalPages: totalPages)
    }

    func didFetchMoviesFailure(with error: any Error) {
        viewModel?.showErrorMessage(error.localizedDescription)
    }
}
