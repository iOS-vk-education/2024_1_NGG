//
//  MovieListAssembler.swift
//  cinematch
//
//  Created by Ксения Панкратова on 27.03.2025.
//

import Foundation

final class MovieListAssembler {
    static func assemble() -> MovieListViewModel {
        let networkService = Network()
        let viewModel = MovieListViewModel()
        let interactor = MovieListInteractor(networkService: networkService)
        let presenter = MovieListPresenter()
        interactor.presenter = presenter
        presenter.viewModel = viewModel
        viewModel.interactor = interactor
        return viewModel
    }
}
