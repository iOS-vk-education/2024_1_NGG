//
//  SimilarAnimeView.swift
//  animatch
//
//  Created by Ксения Панкратова on 03.12.2024.
//

import SwiftUI

struct SimilarAnimeView: View {
    let images: Module

    var body: some View {
        HStack {
            ForEach(images.similarMovies){ movie in
                if let imageData = movie.imagesData.first, let uiImage = UIImage(data: imageData) {
                    VStack(alignment: .leading) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 64, height: 90)
                            .clipped()
                            .frame(maxWidth: .infinity)
                    }
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    SimilarAnimeView(images: .mockData)
}
