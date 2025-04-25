//
//  EditProfileView.swift
//  cinematch
//
//  Created by Ксения Панкратова on 18.11.2024.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    @State var viewModel: EditProfileDisplayLogic & EditProfileViewModelInput
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
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text(viewModel.errorMessage), message: Text(Constants.alertTitle), dismissButton: .default(Text(Constants.alertButtonTitle)))
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

            NGGTextField(title: Constants.nameTextFieldPlaceholder, text: $viewModel.bindingData.inputName)
            NGGTextField(title: Constants.surnameTextFieldPlaceholder, text: $viewModel.bindingData.inputSurname)
        }
        .padding(.horizontal, 60)
        .padding(.top, 50)
    }

    var avatarView: some View {
        AvatarView(image: viewModel.bindingData.inputImage)
            .overlay(alignment: .bottomTrailing) {
                PhotosPicker(selection: $viewModel.bindingData.selectedItem, matching: .images) {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .foregroundStyle(.editProfWhite)
                        .frame(width: 24, height: 24)
                }
            }
            .onChange(of: viewModel.bindingData.selectedItem) { _, newItem in
                viewModel.selectedItemChange(newItem)
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
            NGGLoadingButton(Constants.saveButtonTitle, isLoading: viewModel.isSaving) {
                viewModel.didTapSaveButton()
            }
            .disabled(viewModel.validateFields())
            .padding(.horizontal, 60)
            .padding(.bottom, 8)
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
        static let saveButtonTitle = "Сохранить и продолжить"
        static let alertTitle = "Ошибка"
        static let alertButtonTitle = "Ок"
    }
}
