//
//  SimilarAnimeView.swift
//  animatch
//
//  Created by Ксения Панкратова on 03.12.2024.
//

import SwiftUI

struct SimilarAnimeView: View {
    let images: [String]

    var body: some View {
        HStack {
            ForEach(images, id: \.self) { image in
                oneAnimeCard(image: image)
                    .frame(maxWidth: .infinity)
            }
        }
    }

    private func oneAnimeCard(image: String) -> some View {
        Image(image)
            .resizable()
            .frame(width: 64, height: 90)
            .onTapGesture {
                // TODO: IOS-: Добавить логику обработки нажатий
                print("[DEBUG] Переход на аниме: \(image)")
            }
    }
}

// MARK: - Preview

#Preview{
    SimilarAnimeView(
        images: [
            "totoroSimilar1",
            "totoroSimilar2",
            "totoroSimilar3",
            "totoroSimilar4"
        ]
    )
}
