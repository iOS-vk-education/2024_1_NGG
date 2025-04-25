//
//  SignUpView.swift
//  cinematch
//
//  Created by Ксения Панкратова on 23.11.2024.
//

import SwiftUI

struct SignUpView: View {
    @State var viewModel: SignUpDisplayData & SignUpViewModelInput
    @Environment(StartScreenViewModel.self) private var startScreenViewModel

    var body: some View {
        AdaptiveScrollView {
            VStack(spacing: 0) {
                VStack {
                    formsContainer
                    buttonsContainer
                }
                Spacer()
                footerView
            }
            .frame(maxWidth: .infinity)
        }
        .alert(isPresented: $viewModel.uiProperties.showAlert) {
            Alert(title: Text(Constants.alertTitle), message: Text(viewModel.uiProperties.errorMessage), dismissButton: .default(Text(Constants.alertButtonTitle)))
        }
        .background(Color.background)
        .ignoresSafeArea()
        .onAppear {
            viewModel.setStartScreenViewModel(startScreenViewModel)
        }
    }
}

// MARK: - UI Subviews

private extension SignUpView {

    var formsContainer: some View {
        VStack(spacing: 0) {
            Text(Constants.formsContainerTitle)
                .foregroundStyle(Color.editProfWhite)
                .font(Font.custom("Roboto", size: 32))
                .padding(.bottom, 34)
                .padding(.top, 220)

            NGGTextField(title: Constants.nameTextFieldPlaceholder, text: $viewModel.inputData.email)
            NGGSecureField(Constants.passwordTextFieldPlaceholder, text: $viewModel.inputData.passwordFirst)
            NGGSecureField(Constants.passwordrepeatTextFieldPlaceholder, text: $viewModel.inputData.passwordSecond)
        }
        .padding(.horizontal, 60)
    }

    var buttonsContainer: some View {
        VStack(spacing: 0) {
            NGGLoadingButton(Constants.continueButtonTitle, isLoading: viewModel.uiProperties.isLoading) {
                viewModel.didTapContinue()
            }
        }
        .padding(.horizontal, 60)
    }

    var footerView: some View {
        VStack {
            Divider()
                .overlay(.white)
                .frame(width: 320)

            HStack {
                Text(Constants.haveAccountText)
                    .foregroundStyle(Color.white)
                    .font(Font.custom("Roboto", size: 16))

                Button {
                    viewModel.didTapOpenSignInScreen()
                } label: {
                    Text(Constants.logInButton)
                        .underline()
                        .foregroundColor(.purpleLight)
                }
            }
        }
        .frame(height: 80)
        .padding(.bottom, 100)
    }
}

// MARK: - Preview

#Preview {
    NavigationStack{
        SignUpView(viewModel: SignUpViewModel())
    }
    .environment(StartScreenViewModel())
}

// MARK: - Constants

private extension SignUpView {

    enum Constants {
        static let formsContainerTitle = "Регистрация"
        static let nameTextFieldPlaceholder = "email"
        static let passwordTextFieldPlaceholder = "password"
        static let passwordrepeatTextFieldPlaceholder = "password repeat"
        static let haveAccountText = "Есть аккаунт?"
        static let continueButtonTitle = "Продолжить"
        static let logInButton = "Войдите"
        static let alertTitle = "Ошибка"
        static let alertButtonTitle = "Ок"
    }
}
