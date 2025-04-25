//
//  NGGTextField.swift
//  cinematch
//
//  Created by Ксения Панкратова on 18.11.2024.
//

import SwiftUI

struct NGGTextField: View {
    let title: String
    @Binding var text: String
    @FocusState private var isTyping: Bool

    var body: some View {
        TextField(text: $text) {
            Text(title)
                .foregroundColor(Color.editProfGrayLight)
        }
        .textInputAutocapitalization(.never)
        .padding(.leading, 16)
        .frame(height: 51)
        .foregroundColor(.white)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.textFieldGray, lineWidth: 2)
        )
        .focused($isTyping)
        .padding(.bottom, 30)
    }
}

// MARK: - Preview

#Preview("Text") {
    NGGTextField(title: "Title", text: .constant("Input Text"))
}

#Preview("Placeholder") {
    NGGTextField(title: "Title", text: .constant(""))
}

