//
//  NGGButtonLight.swift
//  animatch
//
//  Created by Ксения Панкратова on 25.11.2024.
//

import SwiftUI

struct NGGButtonLight: View {
    private let title: String
    private var action: (() -> Void)?

    init(_ title: String, action: (() -> Void)? = nil) {
        self.title = title
        self.action = action
    }

    var body: some View {
        Button(title) {
            action?()
        }
        .buttonStyle(LightPurpleButtonStyle())
    }
}

// MARK: - LightPurpleButtonStyle

private struct LightPurpleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(width: 272, height: 51)
            .background(Color.downloadLightPurple)
            .foregroundStyle(Color.editProfWhite)
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

// MARK: - Preview

#Preview {
    NGGButtonLight("Placeholder") {
        print("[DEBUG]: Нажали на кнопку")
    }
}
