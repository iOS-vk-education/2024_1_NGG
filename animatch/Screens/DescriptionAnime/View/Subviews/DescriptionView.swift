//
//  DescriptionView.swift
//  animatch
//
//  Created by Ксения Панкратова on 04.12.2024.
//
import SwiftUI

struct DescriptionView: View {
    let story: DescriptionAnimeModel

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(story.title + "(\(story.year))")
                .font(Font.custom("Roboto", size: 24))

            HStack {
                RatingView(rating: story.rating)
                Spacer()

                VStack(alignment: .trailing) {
                    HStack {
                        Text("Жанр:")
                            .foregroundStyle(Color.gray)
                        Text(story.genre)
                    }

                    HStack {
                        Text("Режиссер:")
                            .foregroundStyle(Color.gray)
                        Text(story.director)
                    }
                }
            }
            Text(story.description)
                .lineLimit(7)
        }
    }
}

// MARK: - Preview

#Preview {
        DescriptionView(story: .mockData).body.preferredColorScheme(.dark)
}
