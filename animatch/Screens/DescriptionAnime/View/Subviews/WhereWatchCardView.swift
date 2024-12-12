//
//  WhereWatchCardView.swift
//  animatch
//
//  Created by Ксения Панкратова on 03.12.2024.
//

import SwiftUI

struct ViewingPlatform: Identifiable {
    let id: Int
    let title: String
    let image: Data
}

struct WhereWatchCardView: View {
    let viewingPlatforms: [ViewingPlatform]

    var body: some View {
        HStack {
            ForEach(viewingPlatforms) { viewingPlatform in
                if let uiImage = UIImage(data: viewingPlatform.image) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .frame(width: 18, height: 18)
                        .clipShape(Circle())
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .frame(width: 18, height: 18)
                        .clipShape(Circle())
                }
                Text(viewingPlatform.title)
            }
        }
        .font(Font.custom("Roboto", size: 12))
        .foregroundStyle(.white)
        .onTapGesture {
            print("[DEBUG] Переход к платформам просмотра")
            // TODO: IOS-: Добавить логику обработки нажатий
        }
    }
}

// MARK: - Preview

#Preview {
    WhereWatchCardView(
        viewingPlatforms: [
            ViewingPlatform(
                id: 1,
                title: "Start",
                image: UIImage.start.pngData() ?? Data()
            ),
            ViewingPlatform(
                id: 2,
                title: "Okko",
                image: Data()
            ),
            ViewingPlatform(
                id: 3,
                title: "Okko",
                image: UIImage.start.pngData() ?? Data()
            )
        ]
    )
}
