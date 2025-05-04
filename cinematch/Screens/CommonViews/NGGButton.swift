//
//  NGGButton.swift
//  cinematch
//
//  Created by Ксения Панкратова on 18.11.2024.
//

import SwiftUI

struct NGGButton: View {
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
        .buttonStyle(PurpleButtonStyle())
    }
}

// MARK: - PurpleButtonStyle

private struct PurpleButtonStyle: ButtonStyle {
    var backgroundLineGradient: some View {
        LinearGradient(
            gradient: Gradient(
                colors: [
                    .purpleLight,
                    .editProfPurple
                ]
            ),
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .frame(height: 50)
            .background(backgroundLineGradient)
            .foregroundStyle(Color.editProfWhite)
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

// MARK: - NGGLoadingButton

struct NGGLoadingButton: View {
    private let title: String
    private let isLoading: Bool
    private var action: (() -> Void)?

    init(_ title: String, isLoading: Bool, action: (() -> Void)? = nil) {
        self.title = title
        self.isLoading = isLoading
        self.action = action
    }

    var body: some View {
        Button(action: {
            if !isLoading {
                action?()
            }
        }) {
            ZStack {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                } else {
                    Text(title)
                }
            }
        }
        .buttonStyle(PurpleButtonStyle())
    }
}

// MARK: - Preview

#Preview {
    NGGButton("Placeholder") {
        print("[DEBUG]: Нажали на кнопку")
    }
    .padding(.horizontal, 60)
}
