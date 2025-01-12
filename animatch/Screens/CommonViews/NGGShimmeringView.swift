//
//  NGGShimmeringView.swift
//  animatch
//
//  Created by Ксения Панкратова on 23.12.2024.
//

import SwiftUI

struct NGGShimmeringView: View {
    var kind: NGGShimmeringKind = .default
    @State private var isAnimating = false
    @State private var startPoint = UnitPoint(x: -1.8, y: -1.2)
    @State private var endPoint = UnitPoint(x: 0, y: -0.2)

    var body: some View {
        LinearGradient(
            colors: kind.colors,
            startPoint: startPoint,
            endPoint: endPoint
        )
        .clipShape(RoundedRectangle(cornerRadius: 10))
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

extension NGGShimmeringView {
    enum NGGShimmeringKind: Hashable {
        case `default`
        case inverted
    }
}

private extension NGGShimmeringView.NGGShimmeringKind {
    var colors: [Color] {
        switch self {
        case .default:
            return [
                Constants.shimmering2,
                Constants.shimmering1,
                Constants.shimmering2,
            ]
        case .inverted:
            return [
                Constants.shimmering1,
                Constants.shimmering2,
                Constants.shimmering1,
            ]
        }
    }
}

// MARK: - Preview

#Preview {
    NGGShimmeringView()
}

// MARK: - Constants

private extension NGGShimmeringView.NGGShimmeringKind {
    enum Constants {
        static let shimmering2 = Color(uiColor: UIColor.cardLightGray)
        static let shimmering1 = Color(uiColor: UIColor.editProfLightGrad)
    }
}
