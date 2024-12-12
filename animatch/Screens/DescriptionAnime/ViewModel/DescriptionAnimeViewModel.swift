//
//  DescriptionAnimeViewModel.swift
//  animatch
//
//  Created by Ксения Панкратова on 03.12.2024.
//

import Foundation
import Observation

// MARK: - DescriptionAnimeViewModelProtocol

protocol DescriptionAnimeViewModelProtocol: AnyObject {
    // Values
    var stories: Module { get }
    var views: [ViewingPlatformModel] { get }
    // Configurations
    func configureAnimeModel() -> DescriptionAnimeModel
}

// MARK: - DescriptionAnimeViewModel

@Observable
final class DescriptionAnimeViewModel: DescriptionAnimeViewModelProtocol {
    private(set) var stories: Module
    private(set) var views: [ViewingPlatformModel]

    init(stories: Module, views: [ViewingPlatformModel]) {
        self.stories = stories
        self.views = views
    }
}

// MARK: - DescriptionAnimeViewModelProtocol

extension DescriptionAnimeViewModel {
    func configureAnimeModel() -> DescriptionAnimeModel {
        DescriptionAnimeModel(story: stories)
    }
}
