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
}

// MARK: - DescriptionAnimeViewModel

@Observable
final class DescriptionAnimeViewModel: DescriptionAnimeViewModelProtocol {
    private(set) var stories: Module

    init(stories: Module) {
        self.stories = stories
    }
}
