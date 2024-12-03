//
//  RatingView.swift
//  animatch
//
//  Created by Ксения Панкратова on 03.12.2024.
//
import SwiftUI

struct RatingView: View {
    let rating: Int

    var body: some View {
        HStack {
            ForEach(1 ..< 6){index in
                Star(fill: fillingFor(index))
            }
            Text("(\(rating))")
        }
    }
    private func fillingFor(_ index: Int) -> Bool {
        index <= rating
    }
}

struct Star: View {
    let fill: Bool

    var body: some View {
        Image(systemName: fill ? "star.fill" :"star")
            .resizable()
            .frame(width: 16, height: 16)
            .foregroundStyle(Color.white)
    }
}

// MARK: - Preview

#Preview {
    RatingView(rating:4)
        .body.preferredColorScheme(.dark)
}
