//
//  LogInView.swift
//  animatch
//
//  Created by Ксения Панкратова on 23.11.2024.

import SwiftUI

struct LogInView: View {
    @State var viewModel: LogInViewModelLogic
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
        .background(backgroundLineGradient)
        .ignoresSafeArea()
        .onAppear {
            viewModel.setStartScreenViewModel(startScreenViewModel)
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Ошибка входа"), message: Text(Constants.errorMessage), dismissButton: .default(Text("OK")))
        }

    }
}

// MARK: - UI Subviews

private extension LogInView {

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
                .font(Font.custom("Roboto", size: 32))
                .padding(.bottom, 34)
                .padding(.top, 250)

            NGGTextField(title: Constants.nameTextFieldPlaceholder, text: $viewModel.email)

            NGGSecureField(Constants.passwordTextFieldPlaceholder, text: $viewModel.password)
        }
        .padding(.horizontal, 60)
    }

    var buttonsContainer: some View {
        VStack(spacing: 0) {

            NGGButton(Constants.continueButtonTitle) {
                viewModel.validateData()
            }
            .padding(.horizontal, 60)
            .padding(.bottom, 80)
        }
    }

    var footerView: some View {
        VStack {
            Divider()
                .overlay(.white)
                .frame(width: 320)

            HStack(spacing: 0) {
                Text(Constants.footerText)
                    .foregroundStyle(Color.white)
                    .font(Font.custom("Roboto", size: 16))

                Button {
                    viewModel.didTapOpenRegistrationScreen()
                } label: {
                    Text(Constants.singupButton)
                        .underline()
                        .foregroundColor(.editProfPurple)
                }
            }
        }
        .padding(.bottom, 130)
    }
}

// MARK: - Preview

#Preview {
    NavigationStack{
        LogInView(viewModel: LogInViewModelMock())
    }
    .environment(StartScreenViewModel())
}

// MARK: - Constants

private extension LogInView {

    enum Constants {
        static let formsContainerTitle = "Вход"
        static let nameTextFieldPlaceholder = "Введите эл. почту"
        static let passwordTextFieldPlaceholder = "Введите пароль"
        static let forgotPasswordButtonTitle = "Забыли пароль?"
        static let continueButtonTitle = "Продолжить"
        static let footerText = "Нет аккаунта? "
        static let singupButton = "Зарегистрируйтесь"
        static let errorMessage = "Неверный email или пароль. Пожалуйста, попробуйте снова."
    }
}
