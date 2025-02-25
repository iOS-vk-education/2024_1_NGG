//
//  ImageCarouselView.swift
//  cinematch
//
//  Created by Ксения Панкратова on 03.12.2024.
//

import SwiftUI

struct ImageCarouselView: View {
    let images: Module
    @State private var currentImage = 0

    var body: some View {
        GeometryReader { geometry in
            let minY = geometry.frame(in: .global).minY
            let iscrolling = minY > 0

            ZStack(alignment: .bottom) {
                TabView(selection: $currentImage) {
                    ForEach(Array(images.imagesData.enumerated()), id: \.0) { index, imageData in
                        if let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width)
                                .clipped()
                                .tag(index)
                        } else {
                            Image(systemName: "photo")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 30, height: 30)
                                .tag(index)
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .frame(height: iscrolling ? 300 + minY: 300)
                .offset(y: iscrolling ? -minY : 0)

                HStack {
                    ForEach(0..<images.imagesData.count, id: \.self) { index in
                        RoundedRectangle(cornerRadius: 20)
                            .fill(
                                index == currentImage ? Color.white : Color.gray.opacity(0.5)
                            )
                            .frame(width: 30, height: 2)
                    }
                }
                .padding(.bottom, minY + 50)
            }
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
