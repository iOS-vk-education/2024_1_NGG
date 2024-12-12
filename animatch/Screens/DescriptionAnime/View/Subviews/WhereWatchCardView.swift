//
//  WhereWatchCardView.swift
//  animatch
//
//  Created by Ксения Панкратова on 03.12.2024.
//

import SwiftUI

struct WhereWatchCardView: View {
    let viewingPlatforms: [ViewingPlatformModel]

    var body: some View {
        HStack {
            ForEach(viewingPlatforms) {model in
                viewingCardView(imageData: model.imageData, title: model.title)
                    .frame(maxWidth: .infinity)
            }
        }
    }

    private func viewingCardView(imageData: Data, title: String) -> some View {
        HStack {
            if let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .frame(width: 18, height: 18)
                    .clipShape(Circle())
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 18, height: 18)
            }

            Text(title)
                .foregroundColor(Color.white)
        }
        .onTapGesture {
            // TODO: IOS-: Добавить логику обработки нажатий
            print("[DEBUG] Переход")
        }
    }
}

// MARK: - Preview

#Preview {
    WhereWatchCardView(
        viewingPlatforms: [
            .mockData,
            .mockData,
            .mockData
        ]
    )
}
