//
//  LogInView.swift
//  cinematch
//
//  Created by Ксения Панкратова on 09.03.2025.
//

import SwiftUI

struct LogInView: UIViewControllerRepresentable {
    let viewModel: LogInViewModelLogic
    let startScreenViewModel: StartScreenViewModel

    func makeUIViewController(context: Context) -> LogInViewController {
        viewModel.setStartScreenViewModel(startScreenViewModel)
        return LogInViewController(viewModel: viewModel)
    }

    func updateUIViewController(_ uiViewController: LogInViewController, context: Context) {}
}
