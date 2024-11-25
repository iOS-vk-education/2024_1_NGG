//
//  NGGSecureField.swift
//  animatch
//
//  Created by Ксения Панкратова on 23.11.2024.
//

import SwiftUI

struct NGGSecureField: View {
    @Binding private var text: String
    @State private var isSecured: Bool = true
    private var title: String

    init(_ title: String, text: Binding<String>) {
        self.title = title
        self._text = text
    }

    var body: some View {
        ZStack(alignment: .trailing) {
            Group {
                if isSecured {
                    StyledSecureField(title: title, text: $text)

                } else {
                    NGGTextField(title: title, text: $text)
                }
            }

            Button(action: {
                isSecured.toggle()
            }) {
                Image(systemName: self.isSecured ? "eye.slash" : "eye")
                    .accentColor(.white)
                    .opacity(0.8)
            }
            .padding(.bottom, 30)
            .padding(.trailing, 5)
        }
    }
}

// MARK: - StyledSecureField

private struct StyledSecureField: View {
    let title: String
    @Binding var text: String
    @FocusState private var isTyping: Bool

    var body: some View {
        ZStack(alignment: .leading) {
            SecureField("", text: $text)
                .padding(.leading, 16)
                .frame(height: 51)
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

#Preview {
    NGGSecureField("Password", text: .constant(""))
        .padding(.horizontal)
}
