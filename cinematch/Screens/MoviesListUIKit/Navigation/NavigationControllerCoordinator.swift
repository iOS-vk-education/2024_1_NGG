//
//  NavigationControllerCoordinator.swift
//  cinematch
//
//  Created by Ксения Панкратова on 06.04.2025.
//

import SwiftUI
import UIKit

@Observable
final class NavigationControllerCoordinator {
    var navigationController: UINavigationController?
    let mainProfileViewModel = MainProfileViewModelMock(delay: 2)

    func addScreen(screen: MovieListScreens) {
        switch screen {
        case let .storyDetails(module):
            let detailsView = DescriptionMovieView(viewModel: DescriptionMovieViewModelMock(story: module))
                .environment(self)
            let hostingController = UIHostingController(rootView: detailsView)
            navigationController?.pushViewController(hostingController, animated: true)
        case .profile:
            let profileView = MainProfileView(viewModel: mainProfileViewModel)
                .environment(self)
            let hostingController = UIHostingController(rootView: profileView)
            navigationController?.pushViewController(hostingController, animated: true)
        case .preferences:
            let preferencesView = PreferencesView(viewModel: PreferencesViewModelMock())
                .environment(self)
            let hostingController = UIHostingController(rootView: preferencesView)
            navigationController?.pushViewController(hostingController, animated: true)
        case .editPreferences:
            let editPreferencesView = EditPreferencesView(viewModel: EditPreferencesViewModelMock())
                .environment(self)
            let hostingController = UIHostingController(rootView: editPreferencesView)
            navigationController?.pushViewController(hostingController, animated: true)
        case .edit:
            let editProfileView = MainEditProfileView(viewModel: MainEditProfileViewModelMock(prevViewModel: mainProfileViewModel))
                .environment(self)
            let hostingController = UIHostingController(rootView: editProfileView)
            navigationController?.pushViewController(hostingController, animated: true)
        }
    }

    func openPreviousScreen() {
        navigationController?.popViewController(animated: true)
    }
}
