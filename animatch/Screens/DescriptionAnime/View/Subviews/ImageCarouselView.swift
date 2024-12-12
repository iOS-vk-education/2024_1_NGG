//
//  ImageCarouselView.swift
//  animatch
//
//  Created by Ксения Панкратова on 03.12.2024.
//

import SwiftUI

struct ImageCarouselView: View {
    let images: DescriptionAnimeModel

    var body: some View {
        GeometryReader { geometry in
            TabView {
                ForEach(images.imagesData, id: \.self) { imageData in
                    if let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: 300)
                            .clipped()
                    } else {
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 30, height: 30)
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle())
        }
        .frame(height: 300)
    }
}

// MARK: - Preview

#Preview {
    ImageCarouselView(images: .mockData)
}
