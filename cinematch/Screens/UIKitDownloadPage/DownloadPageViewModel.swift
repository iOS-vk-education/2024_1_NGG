//
//  DownloadPageViewModel.swift
//  cinematch
//
//  Created by Ксения Панкратова on 17.12.2024.
//

import Foundation

final class DownloadPageViewModel: DownloadPageInput {
    @ObservationIgnored
    private var startScreenViewModel: StartScreenViewModel?

    func setStartScreenViewModel(_ startScreenViewModel: StartScreenViewModel) {
        self.startScreenViewModel = startScreenViewModel
    }

    func didTapLogIn() {
        startScreenViewModel?.updateScreen(newScreenState: .logIn)
    }

    func didTapRegister() {
        startScreenViewModel?.updateScreen(newScreenState: .signUp)
    }
}
