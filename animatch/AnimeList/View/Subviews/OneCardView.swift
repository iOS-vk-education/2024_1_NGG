//
//  OneCardView.swift
//  animatch
//
//  Created by Ксения Панкратова on 27.11.2024.
//

import SwiftUI

struct OneCardView: View {
    let story: OneCardModel
    var onCardTapped: (() -> Void)?

    var body: some View {
        ZStack {
            backgroundView
            cardInfoView
        }
        .onTapGesture {
            // TODO: IOS-: Добавить логику обработки нажатий
            print("[DEBUG] Переход на выбранную карточку")
        }
    }
}

// MARK: - Preview

#Preview {
    OneCardView(story: .mockData)
}
