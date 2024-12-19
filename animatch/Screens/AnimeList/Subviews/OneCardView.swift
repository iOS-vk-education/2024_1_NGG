//
//  OneCardView.swift
//  animatch
//
//  Created by Ксения Панкратова on 27.11.2024.
//

import SwiftUI

struct OneCardView: View {
    let story: Module
    var onCardTapped: (() -> Void)?

    var body: some View {
        ZStack {
            backgroundView
            cardInfoView
        }
    }
}

private extension OneCardView {
    @ViewBuilder
    var backgroundView: some View {
        if let uiImage = UIImage(data: story.mainImage) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFill()
                .frame(height: 110)
                .clipped()
                .blur(radius: 2)
                .overlay(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.black.opacity(0.7), Color.clear]),
                        startPoint: .bottom,
                        endPoint: .top
                    )
                )
                .clipShape(RoundedRectangle(cornerRadius: 15))
        } else {
            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
                .frame(height: 110)
                .foregroundColor(.gray)
                .blur(radius: 2)
                .clipShape(RoundedRectangle(cornerRadius: 15))
        }
    }

    var cardInfoView: some View {
        VStack(spacing: 0) {
            Text(story.title)
                .font(Font.custom("Roboto", size: 32))
                .fontWeight(.bold)
                .foregroundColor(.white)

            HStack {
                Text(story.genre)
                    .foregroundColor(.white)
                Spacer()
                Text(story.type + ",")
                    .foregroundColor(.white)
                Text(String(story.year))
                    .foregroundColor(.white)
            }
            .font(Font.custom("Roboto", size: 14))
            .padding(.vertical, 10)
        }
        .padding(.vertical, 17)
        .padding(.horizontal, 20)
        .frame(height: 110)
    }
}

// MARK: - Preview

#Preview {
    OneCardView(story: .mockData)
}
