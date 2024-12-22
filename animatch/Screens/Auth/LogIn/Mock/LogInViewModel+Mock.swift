//
//  LogInViewModel+Mock.swift
//  animatch
//
//  Created by Ксения Панкратова on 13.12.2024.
//

#if DEBUG

import UIKit
import Foundation

@Observable
final class LogInViewModelMock: LogInViewModelLogic {
    var email: String = ""
    var password: String = ""
    var showAlert: Bool = false

    @ObservationIgnored
    private var startScreenViewModel: StartScreenViewModel?
}

// MARK: - LogInViewModelInput

extension LogInViewModelMock {
    func didTapContinue() {
        startScreenViewModel?.updateScreen(newScreenState: .animeList)
    }

    func didTapOpenRegistrationScreen() {
        startScreenViewModel?.updateScreen(newScreenState: .signUp)
    }

    func validateData(){
        if UserDefaults.standard.string(forKey: "State") == "singUpButExit" {
            didTapContinue()
            UserDefaults.standard.set(startScreenViewModel?.currentScreenState.rawValue, forKey: "State")
        } else {
            showAlert = true
        }
    }

    func setStartScreenViewModel(_ startScreenViewModel: StartScreenViewModel) {
        self.startScreenViewModel = startScreenViewModel
    }
}

#endif
