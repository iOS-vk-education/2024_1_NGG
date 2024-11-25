//
//  DownloadWithProfileView.swift
//  animatch
//
//  Created by Ксения Панкратова on 25.11.2024.
//

import SwiftUI

struct DownloadWithProfileView: View {
    
    var body: some View {
        VStack(spacing: 0) {
            NGGLogoView()
            userView
            buttonsContainer
        }
        .frame(maxWidth: .infinity)
        .background(backgroundLineGradient)
        .ignoresSafeArea()
    }
}

// MARK: - UI Subviews

private extension DownloadWithProfileView {
    
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
    
    var userView: some View {
        VStack(spacing: 0) {
            Image(systemName: "person.fill")
                .resizable()
                .frame(width: 62, height: 62)
                .background(Color.gray)
                .clipShape(Circle())
                .padding(.bottom, 19)
            
            HStack {
                Text(Constants.userName)
                    .foregroundColor(.editProfWhite)
                    .font(Font.custom("Roboto", size: 30))
                
                Text(Constants.userSurname)
                    .foregroundColor(.editProfWhite)
                    .font(Font.custom("Roboto", size: 30))
            }
        }
        .padding(.bottom, 20)
    }
    
    var buttonsContainer: some View {
        VStack(spacing: 0) {
            NGGButton(Constants.entryButtonTitle) {
                // TODO: IOS-20: Добавить логику обработки нажатий
                print("[DEBUG]: Вход")
            }
            .padding(.horizontal, 60)
            .padding(.bottom, 15)
            
            Button {
                // TODO: IOS-20: Добавить логику обработки нажатий
                print("[DEBUG]: Выход из профиля")
            } label: {
                Text(Constants.exitProfileTitle)
                    .underline()
                    .foregroundColor(.editProfPurple)
            }
        }
        .padding(.bottom, 150)
    }
}

// MARK: - Preview

#Preview {
    DownloadWithProfileView()
}

// MARK: - Constants

private extension DownloadWithProfileView {
    
    enum Constants {
        static let entryButtonTitle = "Продолжить"
        static let userName = "Имя"
        static let userSurname = "Фамилия"
        static let exitProfileTitle = "Выйти из профиля"
    }
}
