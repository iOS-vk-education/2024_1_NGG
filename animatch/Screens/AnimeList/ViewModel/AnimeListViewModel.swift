//
//  AnimeListViewModel.swift
//  animatch
//
//  Created by Ксения Панкратова on 27.11.2024.
//

import Foundation
import Observation

// MARK: - AnimeListViewModelProtocol

protocol AnimeListViewModelProtocol: AnyObject {
    // Values
    var stories: [Item] { get }
}

// MARK: - AnimeListViewModel

@Observable
final class AnimeListViewModel: AnimeListViewModelProtocol {
    private(set) var stories: [Item]

    init(stories: [Item] = []) {
        self.stories = stories
    }
}
