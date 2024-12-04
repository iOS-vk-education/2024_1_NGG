//
//  ImageCarouselView.swift
//  animatch
//
//  Created by Ксения Панкратова on 03.12.2024.
//

import SwiftUI

struct ImageCarouselView: View {
    let images: [String]

    var body: some View {
        GeometryReader { geometry in
            TabView {
                ForEach(images, id: \.self) { image in
                    Image(image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: 300)
                        .clipped()
                }
            }
            .tabViewStyle(PageTabViewStyle())
        }
        .frame(height: 300)
    }
}

// MARK: - Preview

#Preview{
    ImageCarouselView(images: ["totoro1", "totoro2", "totoro3"])
}
