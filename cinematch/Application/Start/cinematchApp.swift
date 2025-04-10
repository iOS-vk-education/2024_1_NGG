//
//  cinematchApp.swift
//  cinematch
//
//  Created by Ксения Панкратова on 03.11.2024.
//

import SwiftUI
import FirebaseCore
import SkeletonView

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
        coloredAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 24, weight: .semibold)
        ]
        UINavigationBar.appearance().standardAppearance = coloredAppearance

        SkeletonAppearance.default.tintColor = .cardLightGray
        SkeletonAppearance.default.gradient = SkeletonGradient(baseColor: .background)
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
            LogInView(startScreenViewModel: viewModel)
                .ignoresSafeArea()
        case .signUp:
            SignUpView(viewModel: SignUpViewModelMock())
        case .editProfile:
            EditProfileView(viewModel: EditProfileViewModel())
        case .movieList:
            MovieListView()
                .ignoresSafeArea()
        case .choiceGenres:
            ChoiceGenresView(viewModel: ChoiceGenresViewModelMock())
        }
    }
}
