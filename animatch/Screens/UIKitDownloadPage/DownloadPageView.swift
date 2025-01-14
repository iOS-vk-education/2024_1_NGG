//
//  DownloadPageViewWrapper.swift
//  animatch
//
//  Created by Ксения Панкратова on 13.01.2025.
//

import SwiftUI

struct DownloadPageView: UIViewControllerRepresentable {
    let viewModel: DownloadPageViewModel
    let startScreenViewModel: StartScreenViewModel

    func makeUIViewController(context: Context) -> DownloadPageViewController {
        viewModel.setStartScreenViewModel(startScreenViewModel)
        return DownloadPageViewController(viewModel: viewModel)
    }

    func updateUIViewController(_ uiViewController: DownloadPageViewController, context: Context) {}
}
