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

    func updateScreen(newScreenState: StartScreenState) {
        currentScreenState = newScreenState
    }
}
