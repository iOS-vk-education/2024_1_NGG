//
//  NGGShimmeringView.swift
//  animatch
//
//  Created by Ксения Панкратова on 23.12.2024.
//

import SwiftUI

struct NGGShimmeringView: View {
    @State private var isAnimating = false
    @State private var startPoint = UnitPoint(x: -1.8, y: -1.2)
    @State private var endPoint = UnitPoint(x: 0, y: -0.2)

    var body: some View {
        LinearGradient(
            colors: Constants.colors,
            startPoint: startPoint,
            endPoint: endPoint
        )
        .onAppear {
            withAnimation(
                .easeInOut(duration: 2)
                .repeatForever(autoreverses: false)
            ) {
                startPoint = .init(x: 1, y: 1)
                endPoint = .init(x: 2.5, y: 2.2)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    NGGShimmeringView()
}

// MARK: - Constants

private extension NGGShimmeringView {
    enum Constants {
        static let colors = [
            Color(uiColor: UIColor(red: 36/255, green: 36/255, blue: 41/255, alpha: 1)),
            Color(uiColor: UIColor.darkGray),
            Color(uiColor: UIColor(red: 36/255, green: 36/255, blue: 41/255, alpha: 1)),
        ]
    }
}
