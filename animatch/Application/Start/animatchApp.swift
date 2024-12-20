//
//  animatchApp.swift
//  animatch
//
//  Created by Ксения Панкратова on 03.11.2024.
//

import SwiftUI

@main
struct animatchApp: App {
    @State private var viewModel = StartScreenViewModel()

    var body: some Scene {
        WindowGroup {
            if viewModel.isLogin {
                AnimeListView(viewModel: AnimeListViewModelMock(delay: 2))
                    .environment(viewModel)
            } else {
                startScreen
                    .environment(viewModel)
            }
        }
    }
}

private extension animatchApp {
    @ViewBuilder
    var startScreen: some View {
        switch viewModel.currentScreenState {
        case .initial:
            DownloadPageView(viewModel: DownloadPageViewModel())
        case .signIn:
            LogInView(viewModel: LogInViewModelMock())
        case .signUp:
            SingUpView(viewModel: SingUpViewModelMock())
        case .editProfile:
            EditProfileView(viewModel: EditProfileViewModel())
        case .animeList:
            AnimeListView(viewModel: AnimeListViewModelMock(delay: 2))
        }
    }
}
