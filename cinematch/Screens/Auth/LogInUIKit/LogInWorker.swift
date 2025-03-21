//
//  LogInWorker.swift
//  cinematch
//
//  Created by Ксения Панкратова on 17.03.2025.
//

import FirebaseAuth
import FirebaseFirestore

final class LogInWorker: LoginAuthLogic {
    func makeAuth(email: String, password: String) async throws -> UserModel.UserData {
        do {
            let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
            let userId = authResult.user.uid
            let doc = try await Firestore.firestore().collection("users").document(userId).getDocument()

            guard let userData = try? doc.data(as: UserModel.UserData.self) else {
                throw LoginError.emptyData
            }
            return userData
        } catch {
            throw LoginError.wrongEmailOrPassword
        }
    }
}

enum LoginError: Error {
    case wrongEmailOrPassword
    case emptyData

    var localizedDescription: String {
        switch self {
        case .wrongEmailOrPassword:
            return "Неверный email или пароль"
        case .emptyData:
            return "Не удалось получить данные пользователя"
        }
    }
}
