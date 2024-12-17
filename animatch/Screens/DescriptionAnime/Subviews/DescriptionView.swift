//
//  DescriptionView.swift
//  animatch
//
//  Created by Ксения Панкратова on 04.12.2024.
//
import SwiftUI

struct DescriptionView: View {
    let card: Module

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(card.title + "(\(card.year))")
                .font(Font.custom("Roboto", size: 24))

            HStack {
                RatingView(rating: card.rating)
                Spacer()

                VStack(alignment: .trailing) {
                    HStack {
                        Text(Constants.genreTitle)
                            .foregroundStyle(Color.gray)
                        Text(card.genre)
                    }

                    HStack {
                        Text(Constants.directorTitle)
                            .foregroundStyle(Color.gray)
                        Text(card.director)
                    }
                }
            }
            Text(card.description)
        }
    }
}

// MARK: - Preview

#Preview {
    DescriptionView(card: .mockData)
}

// MARK: - Constants

private extension DescriptionView {

    enum Constants {
        static let genreTitle = "Жанр:"
        static let directorTitle = "Режиссер:"
    }
}
