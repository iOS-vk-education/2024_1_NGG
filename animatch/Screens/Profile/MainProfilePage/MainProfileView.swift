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
        mainContainer
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
                    Text(Constants.headerTitle)
                        .font(Font.custom("Roboto", size: 22))
                        .foregroundColor(.white)
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .padding(.trailing, 24)
                        .foregroundStyle(Color.white)
                        .onTapGesture {
                            viewModel.logout()
                        }
                }
            }
            .onAppear {
                UISegmentedControl.appearance().setTitleTextAttributes(
                    [.foregroundColor: UIColor.white],
                    for: .normal
                )
                UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.editProfPurple

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
