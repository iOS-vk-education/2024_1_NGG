//
//  AnimeListView.swift
//  animatch
//
//  Created by Ксения Панкратова on 27.11.2024.
//

import SwiftUI

struct AnimeListView: View {
    @State var viewModel: AnimeListDisplayLogic & AnimeListViewModelOutput
    @State private var coordinator = Coordinator()
//    @Environment(Coordinator.self) private var coordinator

    var body: some View {
        NavigationStack(path: $coordinator.navPath) {
            listContainer
                .frame(maxWidth: .infinity)
                .background(backgroundLineGradient)
                .ignoresSafeArea()
                .navigationDestination(for: AnimeListScreens.self) { screen in
                openNextScreen(for: screen)
            }
        }
        .environment(coordinator)
        .onAppear {
            viewModel.setCoordinator(coordinator)
            viewModel.onAppear()
        }
    }
}

// MARK: - Navigation Destination

private extension AnimeListView {

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
    NavigationStack {
        AnimeListView(viewModel: AnimeListViewModelMock(delay: 2))
    }
//    .environment(Coordinator())
}
