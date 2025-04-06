//
//  MainProfileProtocols.swift
//  cinematch
//
//  Created by Ксения Панкратова on 23.12.2024.
//

import Foundation
import UIKit

protocol MainProfileDisplayLogic: MainProfileViewModelInput {
    var user: UserModel.User { get }
    var stories: [Module] { get }
    var showLoading: Bool { get }
    var selectedTab: Int { get set }
    var tabs: [Tab] { get }
    func getUserImage() -> UIImage?
}

protocol MainProfileViewModelInput {
    func setCoordinator(_ coordinator: NavigationControllerCoordinator)
    func onAppear()
    func didTapCell(story: Module)
    func didTapEdit()
    func didTapPreferences()
    func logout()
    func setStartScreenViewModel(_ startScreenViewModel: StartScreenViewModel)
    func updateProfileImage(imageData: Data)
}

protocol MainProfileViewModelOutput {
    func configureDetailsViewModel(story: Module) -> DescriptionMovieDisplayLogic & DescriptionMovieViewModelOutput
}
