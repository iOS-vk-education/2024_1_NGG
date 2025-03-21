//
//  File.swift
//  cinematch
//
//  Created by Ксения Панкратова on 13.12.2024.
//

import Foundation

enum UserModel {
    struct User {
        var name: String = ""
        var surname: String = ""
        var email: String = ""
        var password: String = ""
        var image: Data?
    }

    struct UserData: Decodable {
        var name: String
        var surname: String
        var email: String
        var password: String
        var image: String?
    }

    struct UIProperties {
        var showAlert: Bool = false
        var errorMessage: String = ""
    }
}
