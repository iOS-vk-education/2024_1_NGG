//
//  DownloadWithoutView.swift
//  animatch
//
//  Created by Ксения Панкратова on 25.11.2024.
//

import SwiftUI

struct DownloadWithoutProfileView: View {

    var body: some View {
        VStack(spacing: 0) {
            NGGLogoView()
            buttonsContainer
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(backgroundLineGradient)
    }
}

// MARK: - UI Subviews

private extension DownloadWithoutProfileView {

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
                // TODO: IOS-20: Добавить логику обработки нажатий
                print("[DEBUG]: Вход")
            }
            .padding(.horizontal, 60)
            .padding(.bottom, 25)

            NGGButtonLight(Constants.registrationButtonTitle) {
                // TODO: IOS-20: Добавить логику обработки нажатий
                print("[DEBUG]: Регистрация")
            }
            .padding(.horizontal, 60)
        }
        .padding(.bottom, 100)
    }
}

// MARK: - Preview

#Preview {
    DownloadWithoutProfileView()
}

// MARK: - Constants

private extension DownloadWithoutProfileView {

    enum Constants {
        static let entryButtonTitle = "Вход"
        static let registrationButtonTitle = "Регистрация"
    }
}
