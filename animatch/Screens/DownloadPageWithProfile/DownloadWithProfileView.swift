//
//  DownloadWithProfileView.swift
//  animatch
//
//  Created by Ксения Панкратова on 25.11.2024.
//

import SwiftUI

struct DownloadWithProfileView: View {
    @State var viewModel: DownloadWithProfileInput
    @State private var coordinator = Coordinator()

    var body: some View {
        NavigationStack(path: $coordinator.navPath) {
            VStack(spacing: 0) {
                NGGLogoView()
                userView
                buttonsContainer
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

private extension DownloadWithProfileView {

    func openNextScreen(for screen: AppScreens) -> some View {
        switch screen {
        case .animeList:
            AnyView(AnimeListView(viewModel: AnimeListViewModelMock(delay: 2)))
        case .logIn:
            AnyView(LogInView(viewModel: LogInViewModelMock()))
        case .editProfile:
            AnyView(EditProfileView(viewModel: EditProfileViewModel()))
        case .registration:
            AnyView(SingUpView(viewModel: SingUpViewModelMock()))
        }
    }
}

// MARK: - UI Subviews

private extension DownloadWithProfileView {

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

    var userView: some View {
        VStack(spacing: 0) {
            Image(systemName: "person.fill")
                .resizable()
                .frame(width: 62, height: 62)
                .background(Color.gray)
                .clipShape(Circle())
                .padding(.bottom, 19)

            HStack {
                Text(Constants.userName)
                    .foregroundColor(.editProfWhite)
                    .font(Font.custom("Roboto", size: 30))

                Text(Constants.userSurname)
                    .foregroundColor(.editProfWhite)
                    .font(Font.custom("Roboto", size: 30))
            }
        }
        .padding(.bottom, 20)
    }

    var buttonsContainer: some View {
        VStack(spacing: 0) {
            NGGButton(Constants.entryButtonTitle) {
                viewModel.didTapContinue(to: .animeList)
            }
            .padding(.horizontal, 60)
            .padding(.bottom, 15)
            
            Button {
                viewModel.didTapContinue(to: .logIn)
            } label: {
                Text(Constants.exitProfileTitle)
                    .underline()
                    .foregroundColor(.editProfPurple)
            }
        }
        .padding(.bottom, 211)
    }
}

// MARK: - Preview

#Preview {
    DownloadWithProfileView(viewModel: DownloadWithProfileViewModel())
}

// MARK: - Constants

private extension DownloadWithProfileView {

    enum Constants {
        static let entryButtonTitle = "Продолжить"
        static let userName = "Имя"
        static let userSurname = "Фамилия"
        static let exitProfileTitle = "Выйти из профиля"
    }
}
