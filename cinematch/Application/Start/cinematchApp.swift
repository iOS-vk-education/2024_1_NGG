//
//  cinematchApp.swift
//  cinematch
//
//  Created by Ксения Панкратова on 03.11.2024.
//

import SwiftUI
import FirebaseCore

final class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct cinematchApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var delegate
    @State private var viewModel = StartScreenViewModel()

    init() {
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithOpaqueBackground()
        coloredAppearance.backgroundColor = .editProfPurple
        UINavigationBar.appearance().standardAppearance = coloredAppearance
    }

    var body: some Scene {
        WindowGroup {
            startScreen
                .environment(viewModel)
        }
    }
}

private extension cinematchApp {
    @ViewBuilder
    var startScreen: some View {
        switch viewModel.currentScreenState {
        case .initial:
            DownloadPageView(viewModel: DownloadPageViewModel(), startScreenViewModel: viewModel)
                .ignoresSafeArea()
        case .logIn:
            LogInView(viewModel: LogInViewModelMock())
        case .signUp:
            SignUpView(viewModel: SignUpViewModelMock())
        case .editProfile:
            EditProfileView(viewModel: EditProfileViewModel())
        case .movieList:
            MovieListView(viewModel: MovieListViewModelMock(delay: 2))
        case .choiceGenres:
            ChoiceGenresView(viewModel: ChoiceGenresViewModelMock())
        }
    }
}
