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
            SimilarAnimeView()
        }
        .padding(.bottom, 41)
    }

    var whereWatchView: some View {
        HStack {
            Text(Constants.whereWatchTitle)
            WhereWatchCard(title: "Start",  image: .image)
            WhereWatchCard(title: "Okko",  image: .image)
            WhereWatchCard(title: "Viji",  image: .image)
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
    }
}
