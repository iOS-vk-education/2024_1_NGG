//
//  DescriptionAnimeSubviews.swift
//  animatch
//
//  Created by Ксения Панкратова on 03.12.2024.
//

import SwiftUI

extension DescriptionAnimeView {

    var descriptionView: some View {
        DescriptionView(story: DescriptionAnimeModel.mockData)
            .font(Font.custom("Roboto", size: 12))
            .padding(.top, 32)
            .foregroundStyle(.white)
    }

    var similarAnimeListView: some View {
        VStack(alignment: .leading, spacing: 11) {
            Text(Constants.similarAnimeTitle)
                .font(Font.custom("Roboto", size: 12))
                .foregroundStyle(.white)
            SimilarAnimeView(images: Constants.similarAnimeList)
        }
        .padding(.bottom, 41)
    }

    var whereWatchView: some View {
        HStack {
            Text(Constants.whereWatchTitle)
            WhereWatchCardView(
                titles: Constants.whereWatchCardTitles,
                images: Constants.whereWatchCardImages
            )
        }
        .font(Font.custom("Roboto", size: 12))
        .foregroundStyle(.white)
    }

    var buttonView: some View {
        ZStack {
            NGGButton(Constants.trailerButtonTitle) {
                // TODO: IOS-: Добавить логику обработки нажатий
                print("[DEBUG]: Трейлер")
            }
            .padding(.horizontal, 26)
            .padding(.bottom, 60)
        }
    }
}

// MARK: - Preview

#Preview{
    NavigationStack{
        DescriptionAnimeView(viewModel: .mockData)
    }
}

// MARK: - Constants

private extension DescriptionAnimeView {

    enum Constants {
        static let trailerButtonTitle = "Трейлер"
        static let whereWatchTitle = "Где посмотреть:"
        static let similarAnimeTitle = "Если вам понравилось это аниме:"
        static let similarAnimeList = ["totoroSimilar1", "totoroSimilar2", "totoroSimilar3", "totoroSimilar4"]
        static let whereWatchCardTitles = ["Start","Okko","Viji"]
        static let whereWatchCardImages = ["start", "Image", "Image"]
    }
}
