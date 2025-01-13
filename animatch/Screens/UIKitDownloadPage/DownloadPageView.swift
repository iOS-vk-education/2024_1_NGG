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
        return DownloadPageViewController(viewModel: viewModel, startScreenViewModel: startScreenViewModel)
    }

    func updateUIViewController(_ uiViewController: DownloadPageViewController, context: Context) {}
}
