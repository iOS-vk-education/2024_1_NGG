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

    var body: some View {
        VStack(spacing: 0) {
            headerView
            Spacer()
            preferenceList
            Spacer()
            buttonContainer
        }
        .frame(maxWidth: .infinity)
        .background(backgroundLineGradient)
        .onAppear {
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
        Text(Constants.headerTitle)
            .foregroundColor(.white)
            .font(Font.custom("Roboto", size: 24))
            .padding(.top, 16)
            .padding(.bottom, 24)
            .frame(maxWidth: .infinity)
            .background(Color.editProfPurple)
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
            .padding(.horizontal, 16)
        }
    }

    var buttonContainer: some View {
        VStack(spacing: 0) {
            NGGButton(Constants.buttonTitle) {
                viewModel.didTapContinue()
            }
            .padding(.horizontal, 60)
            .padding(.bottom, 15)
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