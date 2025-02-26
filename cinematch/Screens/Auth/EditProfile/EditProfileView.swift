//
//  EditProfileView.swift
//  cinematch
//
//  Created by Ксения Панкратова on 18.11.2024.
//

import SwiftUI

struct EditProfileView: View {
    @State var viewModel: EditProfileDisplayLogic
    @State private var isPickerShow = false
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
        .background(Color.background)
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
        AvatarView(image: viewModel.inputImage)
            .overlay(alignment: .bottomTrailing) {
                Button {
                    isPickerShow.toggle()
                } label: {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .foregroundStyle(.editProfWhite)
                        .frame(width: 24, height: 24)
                }
            }
            .sheet(isPresented: $isPickerShow) {
                ImagePicker(image: $viewModel.inputImage)
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
                viewModel.didTapSaveButton()
            }
            .padding(.horizontal, 60)
            .padding(.bottom, 8)

            Button {
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
