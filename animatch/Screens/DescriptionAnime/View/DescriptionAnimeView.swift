//
//  DescriptionAnimeView.swift
//  animatch
//
//  Created by Ксения Панкратова on 03.12.2024.
//

import SwiftUI

struct DescriptionAnimeView: View {
    @State var viewModel: DescriptionAnimeDisplayLogic & DescriptionAnimeViewModelOutput
    @Environment(Coordinator.self) private var coordinator

    var body: some View {
        ScrollView {
            ImageCarouselView(images: viewModel.story)
            VStack(alignment: .leading, spacing: 24) {
                descriptionView
                CustomActionView()
                whereWatchCardView
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
        .onAppear {
            viewModel.setCoordinator(coordinator)
        }
    }

}

// MARK: - Navigation Destination

extension DescriptionAnimeView {

    func openNextScreen(for screen: AnimeListScreens) -> some View {
        switch screen {
        case let .storyDetails(story):
            DescriptionAnimeView(
                viewModel: viewModel.configureDetailsViewModel(story: story)
            )
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack{
        DescriptionAnimeView(
            viewModel: DescriptionAnimeViewModelMock(story: .mockData))
    }
    .environment(Coordinator())
}
