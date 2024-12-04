//
//  WhereWatchCard.swift
//  animatch
//
//  Created by Ксения Панкратова on 03.12.2024.
//

import SwiftUI

struct WhereWatchCard: View {
    let title: String
    let image: UIImage

    var body: some View {
        HStack {
            Image(uiImage: image)
                .resizable()
                .frame(width: 18, height: 18)
                .clipShape(Circle())

            Text(title)
        }
        .onTapGesture {
            // TODO: IOS-: Добавить логику обработки нажатий
            print("[DEBUG] Переход на выбранное аниме")
        }
    }
}

// MARK: - Preview

#Preview{
    WhereWatchCard(title: "текст", image: .image)
}
