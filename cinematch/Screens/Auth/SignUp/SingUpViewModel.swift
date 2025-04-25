//
//  SignUpViewModel.swift
//  cinematch
//
//  Created by Ксения Панкратова on 14.12.2024.
//

import Foundation
import FirebaseAuth
import Combine

@Observable
final class SignUpViewModel: SignUpDisplayData, SignUpViewModelInput {
    var inputData = InputData()
    var uiProperties = SignUpModel.UIProperties()

    @ObservationIgnored
    private var startScreenViewModel: StartScreenViewModel?

    private var cancellables = Set<AnyCancellable>()
}

// MARK: - SignUpViewModelInput

extension SignUpViewModel {
    func setStartScreenViewModel(_ startScreenViewModel: StartScreenViewModel) {
        self.startScreenViewModel = startScreenViewModel
    }

    func didTapOpenSignInScreen() {
        startScreenViewModel?.updateScreen(newScreenState: .logIn)
    }

    func didTapContinue() {
        guard validateFields() else { return }

        uiProperties.isLoading = true

        registerUser(email: inputData.email, password: inputData.passwordFirst)
    }

    private func registerUser(email: String, password: String) {
        Future<AuthDataResult, Error> { promise in
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if let error = error {
                    promise(.failure(error))
                } else if let result = result {
                    promise(.success(result))
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .sink { [weak self] completion in
            guard let self = self else { return }

            self.uiProperties.isLoading = false

            if case let .failure(error) = completion {
                self.uiProperties.showAlert = true
                self.uiProperties.errorMessage = self.mapFirebaseError(error)
            }
        } receiveValue: { [weak self] _ in
            guard let self = self else { return }

            self.uiProperties.isLoading = false
            self.startScreenViewModel?.updateScreen(newScreenState: .editProfile)

            UserDefaults.standard.set(StartScreenState.editProfile.rawValue, forKey: "State")
        }
        .store(in: &cancellables)
    }

    private func validateFields() -> Bool {
        if inputData.email.isEmpty || inputData.passwordFirst.isEmpty || inputData.passwordSecond.isEmpty {
            uiProperties.showAlert = true
            uiProperties.errorMessage = Constants.emptyFields
            return false
        }

        if inputData.passwordFirst != inputData.passwordSecond {
            uiProperties.showAlert = true
            uiProperties.errorMessage = Constants.differPasswords
            return false
        }

        return true
    }

    private func mapFirebaseError(_ error: Error) -> String {
        let nsError = error as NSError

        switch nsError.code {
        case AuthErrorCode.emailAlreadyInUse.rawValue:
            return "Этот email уже используется"
        case AuthErrorCode.invalidEmail.rawValue:
            return "Неверный формат email"
        case AuthErrorCode.weakPassword.rawValue:
            return "Пароль должен быть больше 6 символов"
        case AuthErrorCode.networkError.rawValue:
            return "Отсутствует подключение к интернету"
        default:
            return "Ошибка регистрации"
        }
    }
}

// MARK: - Constants

extension SignUpViewModel {
    enum Constants {
        static let emptyFields = "Заполните все поля"
        static let differPasswords = "Пароли не совпадают"
    }
}
