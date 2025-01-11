//
//  EditProfileView.swift
//  animatch
//
//  Created by Ксения Панкратова on 18.11.2024.
//

import SwiftUI

struct EditProfileView: View {
    @State var viewModel: EditProfileDisplayLogic
    @Environment(StartScreenViewModel.self) private var startScreenViewModel

    var body: some View {
        AdaptiveScrollView {
            VStack(spacing: 0) {
                headerView
                formsContainer
                Spacer()
                buttonsContainer
            }
        }
        .ignoresSafeArea()
        .background(backgroundLineGradient)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(Constants.headerTitle)
                    .font(Font.custom("Roboto", size: 22))
                    .foregroundColor(.white)
            }
        }
        .onAppear {
            viewModel.setStartScreenViewModel(startScreenViewModel)
        }
    }
}

// MARK: - UI Subviews

private extension EditProfileView {

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
            .fill(Color.textFieldGray)
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

            avatarView
                .padding(.top, 107)
        }
    }

    var buttonsContainer: some View {
        VStack(spacing: 0) {
            NGGButton(Constants.saveButtonTitle) {
                print("[DEBUG]: Нажали кнопку сохранить и продолжить")
                viewModel.didTapSaveButton()
            }
            .padding(.horizontal, 60)
            .padding(.bottom, 8)

            Button {
                print("[DEBUG]: Сделать позже")
                viewModel.didTapDoLaterButton()
            } label: {
                Text(Constants.makeLaterButtonTitle)
                    .underline()
                    .foregroundColor(.editProfPurple)
            }
        }
        .padding(.bottom, 100)
    }
}

// MARK: - Preview

#Preview {
    NavigationView {
        EditProfileView(viewModel: EditProfileViewModel())
    }
    .environment(StartScreenViewModel())
}

// MARK: - Constants

private extension EditProfileView {

    enum Constants {
        static let headerTitle = "Профиль"
        static let formsContainerTitle = "Добавьте имя и фамилию"
        static let nameTextFieldPlaceholder = "Имя"
        static let surnameTextFieldPlaceholder = "Фамилия"
        static let emailTextFieldPlaceholder = "pochta@pochta.com"
        static let makeLaterButtonTitle = "Сделать позже"
        static let saveButtonTitle = "Сохранить и продолжить"
    }
}
