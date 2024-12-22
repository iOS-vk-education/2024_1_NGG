//
//  animatcheAppViewModel.swift
//  animatch
//
//  Created by Ксения Панкратова on 18.12.2024.
//

import Foundation

@Observable
final class StartScreenViewModel {
    private(set) var currentScreenState: StartScreenState = .initial
    init() {
        loadScreenState()
    }

    func updateScreen(newScreenState: StartScreenState) {
        currentScreenState = newScreenState
    }

    func loadScreenState() {
        if let savedStateRaw = UserDefaults.standard.string(forKey: "State"),
           let savedState = StartScreenState(rawValue: savedStateRaw) {
            currentScreenState = savedState
        } else {
            currentScreenState = .initial
        }
    }
}
