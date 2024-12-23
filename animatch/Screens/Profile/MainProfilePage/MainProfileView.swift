//
//  MainProfileView.swift
//  animatch
//
//  Created by Ксения Панкратова on 23.12.2024.
//

import SwiftUI

struct MainProfileView: View {
    @State var viewModel: MainProfileDisplayLogic & MainProfileViewModelOutput
    @Environment(Coordinator.self) private var coordinator
    @Environment(StartScreenViewModel.self) private var startScreenViewModel

    var body: some View {
        VStack {
            ZStack {
                backgroundLineGradient

                VStack(spacing: 0) {
                    headerView
                    textContainer
                    buttonContainer
                    listLoadingContent
                }
            }
        }
        .ignoresSafeArea()
        .onAppear {
            viewModel.setStartScreenViewModel(startScreenViewModel)
            viewModel.setCoordinator(coordinator)
            viewModel.onAppear()
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        MainProfileView(viewModel: MainProfileViewModelMock(delay: 2))
    }
    .environment(StartScreenViewModel())
    .environment(Coordinator())
}
