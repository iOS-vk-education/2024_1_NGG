//
//  MovieListView.swift
//  cinematch
//
//  Created by Ксения Панкратова on 27.11.2024.
//

import SwiftUI

struct MovieListView: View {
    @State var viewModel: MovieListDisplayLogic & MovieListViewModelOutput
    @State private var coordinator = Coordinator()
    @Environment(StartScreenViewModel.self) private var startScreenViewModel
    private let mainProfileViewModel = MainProfileViewModelMock(delay: 2)

    var body: some View {
        NavigationStack(path: $coordinator.navPath) {
            mainContent
                .frame(maxWidth: .infinity)
                .background(Color.background)
                .navigationBarTitleDisplayMode(.inline)
                .navigationDestination(for: MovieListScreens.self) { screen in
                    openNextScreen(for: screen)
                        .environment(coordinator)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Image(systemName: "person.fill")
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

private extension MovieListView {
    @ViewBuilder
    func openNextScreen(for screen: MovieListScreens) -> some View {
        switch screen {
        case let .storyDetails(story):
            DescriptionMovieView(viewModel: viewModel.configureDetailsViewModel(story: story))
        case .profile:
            MainProfileView(viewModel: mainProfileViewModel)
        case .edit:
            MainEditProfileView(viewModel: MainEditProfileViewModelMock(prevViewModel: mainProfileViewModel))
        case .preferences:
            PreferencesView(viewModel: PreferencesViewModelMock())
        case .editPreferences:
            EditPreferencesView(viewModel: EditPreferencesViewModelMock())
        }
    }
}

// MARK: - Preview

#Preview {
    MovieListView(viewModel: MovieListViewModelMock(delay: 2))
        .environment(StartScreenViewModel())
}
