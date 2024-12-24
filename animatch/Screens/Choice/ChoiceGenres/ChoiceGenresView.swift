//
//  ChoiceGenresView.swift
//  animatch
//
//  Created by Ксения Панкратова on 18.12.2024.
//

import SwiftUI

struct ChoiceGenresView: View {
    @State var viewModel: ChoiceGenresViewModelLogic
    @Environment(StartScreenViewModel.self) private var startScreenViewModel
    @State private var coordinator = Coordinator()

    var body: some View {
        NavigationStack(path: $coordinator.navPath) {
            VStack(spacing: 0) {
                headerView
                preferenceList
            }
            .navigationDestination(for: PreferenceScreens.self) { screen in
                openNextScreen(for: screen)
                    .environment(coordinator)
            }
            .ignoresSafeArea()
            .background(backgroundLineGradient)
            .overlay(alignment: .bottom) {
                buttonContainer
            }
        }
        .accentColor(.white)
        .onAppear {
            viewModel.setCoordinator(coordinator)
            viewModel.setStartScreenViewModel(startScreenViewModel)
        }
    }
}

// MARK: - UI Subviews

private extension ChoiceGenresView {

    var backgroundLineGradient: some View {
        LinearGradient(
            gradient: Gradient(
                colors: [
                    .editProfLightGrad,
                    .editProfDarkGrad
                ]
            ),
            startPoint: .top,
            endPoint: .center
        )
        .ignoresSafeArea()
    }

    var headerView: some View {
        ZStack(alignment: .top) {
            UnevenRoundedRectangle(
                cornerRadii: .init(
                    bottomLeading: 24,
                    bottomTrailing: 24
                )
            )
            .fill(Color.editProfPurple)
            .frame(height: 130)

            Text(Constants.headerTitle)
                .foregroundStyle(.editProfWhite)
                .font(Font.custom("Roboto", size: 22))
                .padding(.top, 65)
                .padding(.horizontal, 16)
        }
    }

    var preferenceList: some View {
        ScrollView {
            VStack(spacing: 12) {
                ForEach(viewModel.genres, id: \.name) { genre in
                    Button(action: {
                        viewModel.toggleGenreSelection(genre: genre)
                    }) {
                        HStack {
                            Text(genre.name)
                                .foregroundColor(.white)
                                .font(.system(size: 18))

                            Spacer()

                            ZStack {
                                Circle()
                                    .stroke(Color.gray, lineWidth: 2)
                                    .frame(width: 24, height: 24)

                                if genre.isSelected {
                                    Circle()
                                        .fill(Color.purple)
                                        .frame(width: 12, height: 12)
                                }
                            }
                        }
                        .padding()
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                    }
                }
            }
            .padding([.horizontal, .top], 16)
        }
    }

    var buttonContainer: some View {
        NGGButton(Constants.buttonTitle) {
            viewModel.didTapContinue()
        }
        .padding(.horizontal)
        .padding(.bottom, 15)
    }
}

// MARK: - Navigation Destination

private extension ChoiceGenresView {
    @ViewBuilder
    func openNextScreen(for screen: PreferenceScreens) -> some View {
        switch screen {
        case .directors:
            ChoiceDirectorsView(viewModel: ChoiceDirectorsViewModelMock())
        }
    }
}


// MARK: - Preview

#Preview {
    NavigationStack {
        ChoiceGenresView(viewModel: ChoiceGenresViewModelMock())
    }
    .environment(StartScreenViewModel())
}

// MARK: - Constants

private extension ChoiceGenresView {
    enum Constants {
        static let headerTitle = "Выберите жанры аниме"
        static let buttonTitle = "Продолжить"
    }
}
