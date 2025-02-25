//
//  PreferencesProtocols.swift
//  cinematch
//
//  Created by Ксения Панкратова on 04.01.2025.
//

import Foundation

protocol PreferencesDisplayLogic: PreferencesViewModelInput {
    var genres: [String] { get }
    var directors: [String] { get }
}

protocol PreferencesViewModelInput {
    func setCoordinator(_ coordinator: Coordinator)
    func didTapEdit()
    func reloadData()
}
