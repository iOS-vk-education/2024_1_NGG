//
//  MovieListPresenter.swift
//  cinematch
//
//  Created by Ксения Панкратова on 27.03.2025.
//

final class MovieListPresenter: MovieListPresenterInput {
    weak var viewModel: MovieListDisplayLogic!

    func didFetchMoviewSuccess(with movies: [Module]) {
        viewModel?.didFetchMovies(with: movies)
    }

    func didFetchMoviewFailure(with error: any Error) {
        //?
        viewModel?.showErrorMessage(error.localizedDescription)
    }
}
