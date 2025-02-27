//
//  MovieListProtocols.swift
//  cinematch
//
//  Created by Ксения Панкратова on 14.12.2024.
//

import Foundation

protocol MovieListDisplayLogic: MovieListViewModelInput {
    var stories: [Module] { get }
    var showLoading: Bool { get }
}

protocol MovieListViewModelInput {
    func setCoordinator(_ coordinator: Coordinator)
    func onAppear()
    func didTapCell(story: Module)
    func didTapProfile()
    func setStartScreenViewModel(_ startScreenViewModel: StartScreenViewModel)
}

protocol MovieListViewModelOutput {
    func configureDetailsViewModel(story: Module) -> DescriptionMovieDisplayLogic & DescriptionMovieViewModelOutput
}
