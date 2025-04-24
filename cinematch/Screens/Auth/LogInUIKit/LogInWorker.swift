//
//  LogInWorker.swift
//  cinematch
//
//  Created by Ксения Панкратова on 17.03.2025.
//

import FirebaseAuth
import FirebaseFirestore

final class LogInWorker: LoginAuthLogic {
    func makeAuth(email: String, password: String) async throws {
        guard !email.isEmpty && !password.isEmpty else {
            throw LoginError.emptyTestFields
        }

        do {
            try await Auth.auth().signIn(withEmail: email, password: password)
        } catch {
            throw mapFirebaseError(error)
        }
    }
}

private func mapFirebaseError(_ error: Error) -> LoginError {
    let nsError = error as NSError

    switch AuthErrorCode(rawValue: nsError.code) {
    case .wrongPassword, .userNotFound, .invalidEmail:
        return .wrongEmailOrPassword
    case .networkError:
        return .networkError
    case .tooManyRequests:
        return .tooManyAttempts
    default:
        return .unknownError
    }
}

enum LoginError: Error {
    case emptyTestFields
    case wrongEmailOrPassword
    case networkError
    case tooManyAttempts
    case unknownError

    var localizedDescription: String {
        switch self {
        case .emptyTestFields:
            return "Заполните все поля"
        case .wrongEmailOrPassword:
            return "Неверный email или пароль"
        case .networkError:
            return "Отсутствует подключение к интернету"
        case .tooManyAttempts:
            return "Слишком много неудачных попыток. Попробуйте позже"
        case .unknownError:
            return "Ошибка входа"
        }
    }
}
