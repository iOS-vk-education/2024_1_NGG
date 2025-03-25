//
//  LogInWorker.swift
//  cinematch
//
//  Created by Ксения Панкратова on 17.03.2025.
//

import FirebaseAuth
import FirebaseFirestore

final class LogInWorker: LoginAuthLogic {
    func makeAuth(email: String, password: String) async throws -> AuthDataResult {
        guard !email.isEmpty && !password.isEmpty else {
            throw LoginError.emptyTestFields
        }

        do {
            let authResult = try await Auth.auth().signIn(withEmail: email, password: password)

            return authResult
        } catch {
            throw LoginError.wrongEmailOrPassword
        }
    }

    func fetchUserData(authResult: AuthDataResult) async throws -> UserModel.UserData {
        do {
            let userId = authResult.user.uid
            let userData = try await Firestore.firestore().collection("users").document(userId).getDocument().data(as: UserModel.UserData.self)

            return userData
        } catch {
            throw LoginError.emptyData
        }
    }
}

enum LoginError: Error {
    case emptyTestFields
    case wrongEmailOrPassword
    case emptyData

    var localizedDescription: String {
        switch self {
        case .emptyTestFields:
            return "Заполните все поля"
        case .wrongEmailOrPassword:
            return "Неверный email или пароль"
        case .emptyData:
            return "Не удалось получить данные пользователя"
        }
    }
}
