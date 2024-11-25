//
//  SingUpView.swift
//  animatch
//
//  Created by Ксения Панкратова on 23.11.2024.
//

import SwiftUI

struct SingUpView: View {
    @State private var inputEmail = ""
    @State private var inputPasswordFirst = ""
    @State private var inputPasswordSecond = ""

    var body: some View {
        VStack(spacing: 0) {
            logoView
            formsContainer
            buttonsContainer
            Spacer()
            footerView
        }
        .frame(maxWidth: .infinity)
        .background(backgroundLineGradient)
        .ignoresSafeArea()
    }
}

// MARK: - UI Subviews

private extension SingUpView {

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

            NGGTextField(title: Constants.nameTextFieldPlaceholder, text: $inputEmail)
            NGGSecureField(Constants.passwordTextFieldPlaceholder, text: $inputPasswordFirst)
            NGGSecureField(Constants.passwordrepeatTextFieldPlaceholder, text: $inputPasswordSecond)
        }
        .padding(.top, 60)
        .padding(.horizontal, 60)
    }

    var logoView: some View {
        Image(.logo)
            .resizable()
            .frame(width: 209, height: 69)
            .padding(.top, 150)
    }

    var buttonsContainer: some View {
        VStack(spacing: 0) {
            NGGButton(Constants.continueButtonTitle) {
                // TODO: IOS-15: Добавить логику обработки нажатий
                print("[DEBUG]: Продолжить")
            }
        }
        .padding(.horizontal, 60)
        .padding(.bottom, 80)
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
                    // TODO: IOS-15: Добавить логику обработки нажатий
                    print("[DEBUG]: Вход")
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
    SingUpView()
}

// MARK: - Constants

private extension SingUpView {

    enum Constants {
        static let formsContainerTitle = "Регистрация"
        static let nameTextFieldPlaceholder = "Введите эл. почту"
        static let passwordTextFieldPlaceholder = "Введите пароль"
        static let passwordrepeatTextFieldPlaceholder = "Повторите пароль"
        static let haveAccountText = "Есть аккаунт?"
        static let continueButtonTitle = "Продолжить"
        static let singupButton = "Войдите"
    }
}
