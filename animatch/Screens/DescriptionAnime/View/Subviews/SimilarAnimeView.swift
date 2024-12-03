//
//  SimilarAnime.swift
//  animatch
//
//  Created by Ксения Панкратова on 03.12.2024.
//

import SwiftUI

struct SimilarAnimeView: View {
    var body: some View {
        HStack {
            ForEach(1 ... 4, id: \.self){_ in
                OneAnimeCard
            }
            .frame(maxWidth: .infinity)
        }
    }
}

private extension SimilarAnimeView {
    
    var OneAnimeCard: some View {
        Image(.image)
            .resizable()
            .frame(width: 64, height: 90)
            .onTapGesture {
                // TODO: IOS-: Добавить логику обработки нажатий
                print("[DEBUG] Переход на аниме")
            }
    }
}

// MARK: - Preview

#Preview{
    SimilarAnimeView()
}
