//
//  MovieListView.swift
//  cinematch
//
//  Created by Ксения Панкратова on 27.03.2025.
//

import SwiftUI

struct MovieListWrapper: UIViewControllerRepresentable {
    let viewModel: MovieListViewModelInput & MovieListDisplayData & MovieListViewModelOutput
    let startScreenViewModel: StartScreenViewModel
    let coordinator: Coordinator

    func makeUIViewController(context: Context) -> MovieListController {
        viewModel.setStartScreenViewModel(startScreenViewModel)
        viewModel.setCoordinator(coordinator)
        return MovieListController(viewModel: viewModel)
    }

    func updateUIViewController(_ uiViewController: MovieListController, context: Context) {}
}

struct MovieListView: View {
    @State private var coordinator = Coordinator()
    @State private var viewModel = MovieListAssembler.assemble()

    private let mainProfileViewModel = MainProfileViewModelMock(delay: 2)
    @Environment(StartScreenViewModel.self) private var startScreenViewModel

    var body: some View {
        NavigationStack(path: $coordinator.navPath) {
            MovieListWrapper(viewModel: viewModel, startScreenViewModel: startScreenViewModel, coordinator: coordinator)
                .ignoresSafeArea()
                .navigationDestination(for: MovieListScreens.self) { screen in
                    openNextScreen(for: screen)
                        .environment(coordinator)
                }
                .navigationBarBackButtonHidden()
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Image(systemName: "person.fill")
                            .padding(.leading, 10)
                            .foregroundStyle(Color.white)
                            .onTapGesture {
                                viewModel.didTapProfile()
                            }
                    }

                    ToolbarItem(placement: .principal) {
                        Text(Constants.title)
                            .font(Font.custom("Roboto", size: 22))
                            .foregroundColor(.white)
                    }
                }
        }
    }
}

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

private extension MovieListView {
    enum Constants {
        static let title = "Список фильмов"
    }
}
