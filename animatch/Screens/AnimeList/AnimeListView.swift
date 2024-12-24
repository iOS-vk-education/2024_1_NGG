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
    @Environment(StartScreenViewModel.self) private var startScreenViewModel

    var body: some View {
        NavigationStack(path: $coordinator.navPath) {
            mainContent
                .frame(maxWidth: .infinity)
                .background(backgroundLineGradient)
                .navigationBarTitleDisplayMode(.inline)
                .navigationDestination(for: AnimeListScreens.self) { screen in
                    openNextScreen(for: screen)
                        .environment(coordinator)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Image(systemName: "person.fill")
                            .padding(.trailing, 22)
                            .foregroundStyle(Color.white)
                            .onTapGesture {
                                viewModel.didTapProfile()
                            }
                    }

                    ToolbarItem(placement: .principal) {
                        Text(Constants.titleMain)
                            .font(Font.custom("Roboto", size: 22))
                            .foregroundColor(.white)
                    }
                }
        }
        .accentColor(.white)
        .onAppear {
            viewModel.setCoordinator(coordinator)
            viewModel.setStartScreenViewModel(startScreenViewModel)
            viewModel.onAppear()
        }
    }
}

// MARK: - Navigation Destination

private extension AnimeListView {
    @ViewBuilder
    func openNextScreen(for screen: AnimeListScreens) -> some View {
        switch screen {
        case let .storyDetails(story):
            DescriptionAnimeView(
                viewModel: viewModel.configureDetailsViewModel(story: story)
            )
        case .profile:
            MainProfileView(viewModel: MainProfileViewModelMock(delay: 2))
        case .edit:
            MainEditProfileView(viewModel: MainEditProfileViewModelMock())
        }
    }
}

// MARK: - Preview

#Preview {
    AnimeListView(viewModel: AnimeListViewModelMock(delay: 2))
        .environment(StartScreenViewModel())
}
