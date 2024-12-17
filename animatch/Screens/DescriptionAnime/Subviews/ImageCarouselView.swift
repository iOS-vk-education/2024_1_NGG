//
//  ImageCarouselView.swift
//  animatch
//
//  Created by Ксения Панкратова on 03.12.2024.
//

import SwiftUI

struct ImageCarouselView: View {
    let images: Module

    var body: some View {
        GeometryReader { geometry in
            let minY = geometry.frame(in: .global).minY
            let iscrolling = minY > 0

            TabView {
                ForEach(images.imagesData, id: \.self) { imageData in
                    if let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width)
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
            .frame(height: iscrolling ? 300 + minY: 300)
            .offset(y: iscrolling ? -minY : 0)
        }
        .frame(height: 300)
    }
}

// MARK: - Preview

#Preview {
    ScrollView {
        ImageCarouselView(images: .mockData)
    }
}
