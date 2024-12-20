//
//  AnimeListProtocols.swift
//  animatch
//
//  Created by Ксения Панкратова on 14.12.2024.
//

import Foundation

protocol AnimeListDisplayLogic: AnimeListViewModelInput {
    var stories: [Module] { get }
    var showLoading: Bool { get }
}

protocol AnimeListViewModelInput {
    func setCoordinator(_ coordinator: Coordinator)
    func onAppear()
    func didTapCell(story: Module)
    func logOut()
    func setStartScreenViewModel(_ startScreenViewModel: StartScreenViewModel)
}

protocol AnimeListViewModelOutput {
    func configureDetailsViewModel(story: Module) -> DescriptionAnimeDisplayLogic & DescriptionAnimeViewModelOutput
}
