//
//  MovieListView.swift
//  cinematch
//
//  Created by Ксения Панкратова on 27.03.2025.
//

import SwiftUI

struct MovieListView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UINavigationController {
            let navigationController = UINavigationController()
            let viewModel = MovieListAssembler.assemble()
            let movieListController = MovieListController(viewModel: viewModel)

            navigationController.viewControllers = [movieListController]

            return navigationController
        }

    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {}
}
