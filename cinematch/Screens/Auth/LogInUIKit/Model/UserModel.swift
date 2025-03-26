//
//  File.swift
//  cinematch
//
//  Created by Ксения Панкратова on 13.12.2024.
//

import Foundation

enum UserModel {
    struct User {
        var id = ""
        var name = ""
        var surname = ""
        var email = ""
        var image: Data?
    }

    struct UserData: Decodable {
        var id: String
        var name: String
        var surname: String
        var email: String
        var password: String
        var image: String?
    }

    struct UIProperties {
        var email = ""
        var password = ""
    }
}
