//
//  MainEditProfileView.swift
//  animatch
//
//  Created by Ксения Панкратова on 23.12.2024.
//

import SwiftUI

struct MainEditProfileView: View {
    @State var viewModel: MainEditProfileDisplayLogic
    @Environment(Coordinator.self) private var coordinator

    var body: some View {
        AdaptiveScrollView {
            VStack(spacing: 0) {
                headerView
                formsContainer
                Spacer()
                buttonsContainer
            }
        }
        .background(Color.background)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(Constants.headerTitle)
                    .font(Font.custom("Roboto", size: 22))
                    .foregroundColor(.white)
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Image(systemName: "arrow.left")
                    .foregroundStyle(Color.white)
                    .onTapGesture {
                        coordinator.openPreviousScreen()
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

    var formsContainer: some View {
        VStack(spacing: 0) {
            NGGTextField(title: Constants.nameTextFieldPlaceholder, text: $viewModel.inputName)
            NGGTextField(title: Constants.surnameTextFieldPlaceholder, text: $viewModel.inputSurname)
            NGGTextField(title: Constants.emailTextFieldPlaceholder, text: $viewModel.inputEmail)
        }
        .padding(.horizontal, 60)
        .padding(.top, 80)
    }

    var avatarView: some View {
        AvatarView()
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
        static let headerTitle = "Редактирование"
        static let nameTextFieldPlaceholder = "Имя"
        static let surnameTextFieldPlaceholder = "Фамилия"
        static let emailTextFieldPlaceholder = "pochta@pochta.com"
        static let saveButtonTitle = "Сохранить"
    }
}
