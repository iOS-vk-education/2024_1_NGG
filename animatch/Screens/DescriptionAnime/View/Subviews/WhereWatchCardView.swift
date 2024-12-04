//
//  WhereWatchCardView.swift
//  animatch
//
//  Created by Ксения Панкратова on 03.12.2024.
//

import SwiftUI

struct WhereWatchCardView: View {
    let titles: [String]
    let images: [String]

    var body: some View {
        HStack {
            ForEach(Array(zip(titles, images)), id: \.0) { (title, image) in
                cardView(image: image, title: title)
                Spacer()
            }
        }
    }

    private func cardView(image: String, title: String) -> some View {
        HStack {
            Image(image)
                .resizable()
                .frame(width: 18, height: 18)
                .clipShape(Circle())

            Text(title)
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
        titles: ["Start", "Okko", "Viji"],
        images: ["Image", "Image", "Image"]
    )
}
