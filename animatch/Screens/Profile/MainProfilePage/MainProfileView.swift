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
            ScrollView{
                ZStack {
                    VStack(spacing: 0) {
                        headerView
                        textContainer
                        buttonContainer
                        listLoadingContent
                    }
                }
            }
            .background(backgroundLineGradient)
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Image(systemName: "arrow.left")
                    .padding(.leading, 22)
                    .foregroundStyle(Color.white)
                    .onTapGesture {
                        coordinator.openPreviousScreen()
                    }
            }

            ToolbarItem(placement: .principal) {
                    Text("Профиль")
                        .font(Font.custom("Roboto", size: 20))
                        .foregroundColor(.white)
                }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Image(systemName: "rectangle.portrait.and.arrow.right")
                    .padding(.trailing, 22)
                    .foregroundStyle(Color.white)
                    .onTapGesture {
                        viewModel.logout()
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
