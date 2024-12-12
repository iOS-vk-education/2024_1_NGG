//
//  SimilarAnimeView.swift
//  animatch
//
//  Created by Ксения Панкратова on 03.12.2024.
//

import SwiftUI

struct SimilarAnimeView: View {
    let images: DescriptionAnimeModel

    var body: some View {
        HStack {
            ForEach(images.similarMovies, id: \.self) { image in
                if let uiImage = UIImage(data: image) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .frame(width: 64, height: 90)
                        .onTapGesture {
                            // TODO: IOS-: Добавить логику обработки нажатий
                            print("[DEBUG] Переход на аниме")
                        }
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 30, height: 30)
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}

// MARK: - Preview

#Preview {
    SimilarAnimeView(images: .mockData)
}
