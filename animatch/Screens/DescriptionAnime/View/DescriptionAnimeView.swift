//
//  DescriptionAnimeView.swift
//  animatch
//
//  Created by Ксения Панкратова on 03.12.2024.
//

import SwiftUI

struct DescriptionAnimeView: View {
    @State var viewModel = DescriptionAnimeViewModel()

    var body: some View {
        ScrollView {
            ImageCarouselView(images: ["totoro1", "totoro2", "totoro3"])
            VStack(alignment: .leading, spacing: 24) {
                descriptionView
                ActionListView()
                whereWatchView
                similarAnimeListView
                buttonView
            }
            .padding(.horizontal, 34)
            .background(.editProfDarkGrad)
            .frame(maxWidth: .infinity)
            .clipShape(
                RoundedRectangle(cornerRadius: 40)
            )
            .padding(.top, -45)
        }
        .background(Color.editProfDarkGrad)
        .ignoresSafeArea()
    }
}

// MARK: - Preview

#Preview{
    NavigationStack{
        DescriptionAnimeView(viewModel: .mockData)
    }
}
