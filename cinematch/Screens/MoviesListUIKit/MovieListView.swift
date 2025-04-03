//
//  MovieListView.swift
//  cinematch
//
//  Created by Ксения Панкратова on 27.03.2025.
//

import SwiftUI

struct MovieListView: UIViewControllerRepresentable {
    let viewModel = MovieListAssembler.assemble()

    func makeUIViewController(context: Context) -> UINavigationController {
        let movieListVC = MovieListController(viewModel: viewModel)
        return UINavigationController(rootViewController: movieListVC)
    }

    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {}
}
