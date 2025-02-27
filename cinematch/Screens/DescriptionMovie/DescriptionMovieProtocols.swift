//
//  DescriptionMovieProtocols.swift
//  cinematch
//
//  Created by Ксения Панкратова on 14.12.2024.
//

import Foundation

protocol DescriptionMovieDisplayLogic: DescriptionMovieViewModelInput {
    var story: Module { get }
}

protocol DescriptionMovieViewModelInput {
    func setCoordinator(_ coordinator: Coordinator)
    func didTapOpenSimilarStory(movie: Module)
}

protocol DescriptionMovieViewModelOutput {
    func configureDetailsViewModel(story: Module) -> DescriptionMovieDisplayLogic & DescriptionMovieViewModelOutput
}
