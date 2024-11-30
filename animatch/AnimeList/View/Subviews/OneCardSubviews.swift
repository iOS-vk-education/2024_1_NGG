//
//  BackgroundSubviews.swift
//  animatch
//
//  Created by Ксения Панкратова on 30.11.2024.
//
import SwiftUI

extension OneCardView {

    var backgroundView: some View {
        Image(.image)
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
            .clipShape(.rect(cornerRadius: 15))
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
                Text(story.type)
                    .foregroundColor(.white)
                Text(story.date)
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
    NavigationStack {
        OneCardView(story: .mockData)
    }
}
