//
//  NGGTextField.swift
//  animatch
//
//  Created by Ксения Панкратова on 18.11.2024.
//

import SwiftUI

struct NGGTextField: View {
    let title: String
    @Binding var text: String
    @FocusState private var isTyping: Bool

    var body: some View {
        ZStack(alignment: .leading) {
            TextField("", text: $text)
                .padding(.leading, 16)
                .frame(width: 272, height: 51)
                .foregroundColor(.white)
                .background(RoundedRectangle(cornerRadius: 8).fill(Color.editProfGray))
                .focused($isTyping)

            if text.isEmpty {
                Text(title)
                    .padding(.horizontal, 16)
                    .foregroundColor(Color.editProfGrayLight)
            }
        }
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

