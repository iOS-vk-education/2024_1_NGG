//
//  MovieListProtocols.swift
//  cinematch
//
//  Created by Ксения Панкратова on 27.03.2025.
//

import Foundation

// MARK: - ViewModel

protocol MovieListDisplayData: AnyObject {
    var stories: [Module] { get }
    var showLoading: Bool { get }
    var user: UserModel.User { get }
}

protocol MovieListViewModelInput: AnyObject {
    func setCoordinator(_ coordinator: NavigationControllerCoordinator)
    func onAppear(completion: @escaping () -> Void)
}

protocol MovieListViewModelOutput: AnyObject {
    func configureDetailsViewModel(story: Module) -> DescriptionMovieDisplayLogic & DescriptionMovieViewModelOutput
    func didTapCell(story: Module)
    func didTapProfile()
}

protocol MovieListDisplayLogic: AnyObject {
    func didFetchMovies(with movies: [Module])
    func showErrorMessage(_ message: String)
}

// MARK: - Interactor

protocol MovieListBusinessLogic {
    func getMovies() async
}

// MARK: - Presenter

protocol MovieListPresenterInput {
    func didFetchMoviewSuccess(with movies: [Module])
    func didFetchMoviewFailure(with error: Error)
}
