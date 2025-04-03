//
//  MovieListNavigation.swift
//  cinematch
//
//  Created by Ксения Панкратова on 02.04.2025.
//

import UIKit
import SwiftUI

extension MovieListController {
    func openNextScreen(for screen: MovieListScreens, viewModel: MovieListViewModelOutput, coordinator: Coordinator) {
        let destination: UIViewController

        switch screen {
        case let .storyDetails(story):
            let view = DescriptionMovieView(viewModel: viewModel.configureDetailsViewModel(story: story))
                .environment(coordinator)
            destination = UIHostingController(rootView: view)

        case .profile:
            let view = MainProfileView(viewModel: MainProfileViewModelMock(delay: 2))
                .environment(coordinator)
            destination = UIHostingController(rootView: view)

        case .edit:
            let view = MainEditProfileView(
                viewModel: MainEditProfileViewModelMock(prevViewModel: MainProfileViewModelMock(delay: 2))
            )
                .environment(coordinator)
            destination = UIHostingController(rootView: view)

        case .preferences:
            let view = PreferencesView(viewModel: PreferencesViewModelMock())
                .environment(coordinator)
            destination = UIHostingController(rootView: view)

        case .editPreferences:
            let view = EditPreferencesView(viewModel: EditPreferencesViewModelMock())
                .environment(coordinator)
            destination = UIHostingController(rootView: view)
        }

        navigationController?.pushViewController(destination, animated: true)
    }
}
