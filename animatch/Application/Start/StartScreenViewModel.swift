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

    var isLogin: Bool = false

    init() {
        if UserDefaults.standard.bool(forKey: "isLogin") {
            isLogin = true
        }
    }

    func updateScreen(newScreenState: StartScreenState) {
        currentScreenState = newScreenState
    }

    func goToLogIn() {
        currentScreenState = .initial
    }
}
