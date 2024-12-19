//
//  DescriptionAnimeProtocols.swift
//  animatch
//
//  Created by Ксения Панкратова on 14.12.2024.
//

import Foundation

protocol DescriptionAnimeDisplayLogic: DescriptionAnimeViewModelInput {
    var story: Module { get }
}

protocol DescriptionAnimeViewModelInput {
    func setCoordinator(_ coordinator: Coordinator)
    func didTapOpenSimilarStory(movie: Module)
}

protocol DescriptionAnimeViewModelOutput {
    func configureDetailsViewModel(story: Module) -> DescriptionAnimeDisplayLogic & DescriptionAnimeViewModelOutput
}
