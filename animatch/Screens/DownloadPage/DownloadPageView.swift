//
//  DownloadPageView.swift
//  animatch
//
//  Created by Ксения Панкратова on 25.11.2024.
//

import SwiftUI

struct DownloadPageView: View {
    @State var viewModel: DownloadPageInput
    @Environment(StartScreenViewModel.self) private var startScreenViewModel

    var body: some View {
        VStack(spacing: 0) {
            NGGLogoView()
            buttonsContainer
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(backgroundLineGradient)
        .accentColor(.white)
        .onAppear {
            viewModel.setStartScreenViewModel(startScreenViewModel)
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
                viewModel.didTapLogIn()
            }
            .padding(.horizontal, 60)
            .padding(.bottom, 25)

            NGGButtonLight(Constants.registrationButtonTitle) {
                viewModel.didTapRegister()
            }
            .padding(.horizontal, 60)
        }
        .padding(.bottom, 100)
    }
}

// MARK: - Preview

#Preview {
    DownloadPageView(viewModel: DownloadPageViewModel())
        .environment(StartScreenViewModel())
}

// MARK: - Constants

private extension DownloadPageView {

    enum Constants {
        static let entryButtonTitle = "Вход"
        static let registrationButtonTitle = "Регистрация"
    }
}
