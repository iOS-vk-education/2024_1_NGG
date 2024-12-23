//
//  MainEditProfileView.swift
//  animatch
//
//  Created by Ксения Панкратова on 23.12.2024.
//

import SwiftUI

struct MainEditProfileView: View {
    @State var viewModel: MainEditProfileViewModelLogic
    @Environment(Coordinator.self) private var coordinator

    var body: some View {
        VStack {
            ZStack {
                backgroundLineGradient

                VStack(spacing: 0) {
                    headerView
                    formsContainer
                    Spacer()
                    buttonsContainer
                }
            }
        }
        .ignoresSafeArea()
        .onAppear {
            viewModel.setCoordinator(coordinator)
        }
    }
}

// MARK: - UI Subviews

private extension MainEditProfileView {

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

    var formsContainer: some View {
        VStack(spacing: 0) {
            Text(Constants.formsContainerTitle)
                .foregroundStyle(Color.editProfWhite)
                .font(Font.custom("Roboto", size: 20))
                .padding(.top, 39)
                .padding(.bottom, 20)

            NGGTextField(title: Constants.nameTextFieldPlaceholder, text: $viewModel.inputName)
            NGGTextField(title: Constants.surnameTextFieldPlaceholder, text: $viewModel.inputSurname)
            NGGTextField(title: Constants.emailTextFieldPlaceholder, text: $viewModel.inputEmail)
        }
        .padding(.horizontal, 60)
    }

    var avatarView: some View {
        RoundedRectangle(cornerRadius: 30)
            .fill(Color.editProfGray)
            .frame(width: 150, height: 150)
            .overlay(alignment: .bottomTrailing) {
                Button {
                    // TODO: IOS-12: Добавить логику обработки нажатий
                    print("[DEBUG]: Добавить аватар")
                } label: {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .foregroundStyle(.editProfWhite)
                        .frame(width: 24, height: 24)
                }
            }
    }

    var headerView: some View {
        ZStack(alignment: .top) {
            UnevenRoundedRectangle(
                cornerRadii: .init(
                    bottomLeading: 24,
                    bottomTrailing: 24
                )
            )
            .fill(Color.editProfPurple)
            .frame(height: 166)

            Text(Constants.headerTitle)
                .foregroundStyle(.editProfWhite)
                .font(Font.custom("Roboto", size: 20))
                .padding(.top, 65)
                .padding(.horizontal, 16)

            avatarView
                .padding(.top, 107)
        }
    }

    var buttonsContainer: some View {
        VStack(spacing: 0) {
            NGGButton(Constants.saveButtonTitle) {
                viewModel.didTapSaveButton()
            }
            .padding(.horizontal, 60)
            .padding(.bottom, 8)
        }
        .padding(.bottom, 100)
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        MainEditProfileView(viewModel: MainEditProfileViewModelMock())
    }
    .environment(Coordinator())
}

// MARK: - Constants

private extension MainEditProfileView {

    enum Constants {
        static let headerTitle = "Профиль"
        static let formsContainerTitle = "Добавьте имя и фамилию"
        static let nameTextFieldPlaceholder = "Имя"
        static let surnameTextFieldPlaceholder = "Фамилия"
        static let emailTextFieldPlaceholder = "pochta@pochta.com"
        static let saveButtonTitle = "Сохранить"
    }
}
