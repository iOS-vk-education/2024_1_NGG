//
//  DownloadPageView.swift
//  animatch
//
//  Created by Ксения Панкратова on 25.11.2024.
//

import SwiftUI

struct DownloadPageView: View {
    @State var viewModel: DownloadPageInput
    @State private var coordinator = Coordinator()

    var body: some View {
        NavigationStack(path: $coordinator.navPath) {
            VStack(spacing: 0) {
                NGGLogoView()
                buttonsContainer
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .background(backgroundLineGradient)
            .navigationDestination(for: AppScreens.self) { screen in
                openNextScreen(for: screen)
            }
        }
        .accentColor(.white)
        .environment(coordinator)
        .onAppear {
            viewModel.setCoordinator(coordinator)
        }
    }
}

// MARK: - Navigation Destination

private extension DownloadPageView {

    func openNextScreen(for screen: AppScreens) -> some View {
        switch screen {
        case .logIn:
            AnyView(LogInView(viewModel: LogInViewModelMock()))
        case .registration:
            AnyView(SingUpView(viewModel: SingUpViewModelMock()))
        case .animeList:
            AnyView(AnimeListView(viewModel: AnimeListViewModelMock(delay: 2)))
        case .editProfile:
            AnyView(EditProfileView(viewModel: EditProfileViewModel()))
        }
    }
}

// MARK: - UI Subviews

private extension DownloadPageView {

    var backgroundLineGradient: some View {
        LinearGradient(
            gradient: Gradient(
                colors: [
                    .editProfLightGrad,
                    .editProfDarkGrad
                ]
            ),
            startPoint: .top,
            endPoint: .center
        )
        .ignoresSafeArea()
    }

    var buttonsContainer: some View {
        VStack(spacing: 0) {
            NGGButton(Constants.entryButtonTitle) {
                viewModel.didTapContinue(to: .logIn)
            }
            .padding(.horizontal, 60)
            .padding(.bottom, 25)

            NGGButtonLight(Constants.registrationButtonTitle) {
                viewModel.didTapContinue(to: .registration)
            }
            .padding(.horizontal, 60)
        }
        .padding(.bottom, 100)
    }
}

// MARK: - Preview

#Preview {
    DownloadPageView(viewModel: DownloadPageViewModel())
}

// MARK: - Constants

private extension DownloadPageView {

    enum Constants {
        static let entryButtonTitle = "Вход"
        static let registrationButtonTitle = "Регистрация"
    }
}
