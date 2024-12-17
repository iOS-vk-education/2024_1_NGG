//
//  LogInView.swift
//  animatch
//
//  Created by Ксения Панкратова on 23.11.2024.

import SwiftUI

struct LogInView: View {
    @State var viewModel: LogInViewModelLogic
    @Environment(Coordinator.self) private var coordinator
    @State private var showAlert = false
    @State private var errorMessage = ""

    var body: some View {
        VStack(spacing: 0) {
            logoView
                .padding(.bottom, 66)
            formsContainer
            buttonsContainer
            Spacer()
            footerView
        }
        .frame(maxWidth: .infinity)
        .background(backgroundLineGradient)
        .ignoresSafeArea()
        .navigationBarBackButtonHidden()
        .onAppear {
            viewModel.setCoordinator(coordinator)
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Ошибка входа"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
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
                .padding(.bottom, 53)

            NGGTextField(title: Constants.nameTextFieldPlaceholder, text: $viewModel.email)

            NGGSecureField(Constants.passwordTextFieldPlaceholder, text: $viewModel.password)
        }
        .padding(.horizontal, 60)
    }

    var logoView: some View {
        Image(.logo)
            .resizable()
            .frame(width: 209, height: 69)
            .padding(.top, 140)
    }

    var buttonsContainer: some View {
        VStack(spacing: 0) {

            NGGButton(Constants.continueButtonTitle) {
                if viewModel.validateData() {
                    viewModel.didTapContinue(to: .animeList)
                } else {
                    errorMessage = "Неверный email или пароль. Пожалуйста, попробуйте снова."
                    showAlert = true
                }
            }
            .padding(.horizontal, 60)
            .padding(.bottom, 8)

            Button {
                // TODO: IOS-16: Добавить логику обработки нажатий
                print("[DEBUG]: Восстановление пароля")
            } label: {
                Text(Constants.forgotPasswordButtonTitle)
                    .underline()
                    .foregroundColor(.editProfPurple)
            }
        }
        .padding(.bottom, 100)
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
                    viewModel.didTapContinue(to: .registration)
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
    .environment(Coordinator())
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
    }
}
