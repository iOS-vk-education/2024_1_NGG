//
//  MainProfileProtocols.swift
//  animatch
//
//  Created by Ксения Панкратова on 23.12.2024.
//

import Foundation

protocol MainProfileDisplayLogic: MainProfileViewModelInput {
    var user: UserModel { get }
    var stories: [Module] { get }
    var showLoading: Bool { get }
}

protocol MainProfileViewModelInput {
    func setCoordinator(_ coordinator: Coordinator)
    func onAppear()
    func didTapCell(story: Module)
    func didTapEdit()
    func logout()
    func setStartScreenViewModel(_ startScreenViewModel: StartScreenViewModel)
}

protocol MainProfileViewModelOutput {
    func configureDetailsViewModel(story: Module) -> DescriptionAnimeDisplayLogic & DescriptionAnimeViewModelOutput
}
