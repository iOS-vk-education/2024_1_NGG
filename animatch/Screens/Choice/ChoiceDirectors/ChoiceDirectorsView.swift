//
//  ChoiceDirectorsView.swift
//  animatch
//
//  Created by Ксения Панкратова on 18.12.2024.
//

import SwiftUI

struct ChoiceDirectorsView: View {
    @State var viewModel: ChoiceDirectorsViewModelLogic
    @Environment(StartScreenViewModel.self) var startScreenViewModel
    @Environment(Coordinator.self) var coordinator

    var body: some View {
        VStack(spacing: 0) {
            headerView
            preferenceList
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(Constants.headerTitle)
                    .font(Font.custom("Roboto", size: 22))
                    .foregroundColor(.white)
            }

            ToolbarItem(placement: .navigationBarLeading) {
                Image(systemName: "arrow.left")
                    .padding(.leading, 10)
                    .foregroundStyle(Color.white)
                    .onTapGesture {
                        coordinator.openPreviousScreen()
                    }
            }
        }
        .ignoresSafeArea()
        .background(backgroundLineGradient)
        .overlay(alignment: .bottom) {
            buttonContainer
        }
        .onAppear {
            viewModel.setStartScreenViewModel(startScreenViewModel)
            viewModel.setCoordinator(coordinator)
        }
    }
}

// MARK: - UI Subviews

private extension ChoiceDirectorsView {

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
//        ZStack(alignment: .top) {
            UnevenRoundedRectangle(
                cornerRadii: .init(
                    bottomLeading: 24,
                    bottomTrailing: 24
                )
            )
            .fill(Color.editProfPurple)
            .frame(height: 130)
//        }
    }

    var preferenceList: some View {
        ScrollView {
            VStack(spacing: 12) {
                ForEach(viewModel.directors, id: \.name) { director in
                    Button(action: {
                        viewModel.toggleDirectorSelection(director: director)
                    }) {
                        HStack {
                            Text(director.name)
                                .foregroundColor(.white)
                                .font(.system(size: 18))
                            Spacer()

                            ZStack {
                                Circle()
                                    .stroke(Color.gray, lineWidth: 2)
                                    .frame(width: 24, height: 24)

                                if director.isSelected {
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

// MARK: - Preview

#Preview {
    NavigationStack{
        ChoiceDirectorsView(viewModel: ChoiceDirectorsViewModelMock())
    }
    .environment(StartScreenViewModel())
    .environment(Coordinator())
}

// MARK: - Constants

private extension ChoiceDirectorsView {

    enum Constants {
        static let headerTitle = "Выберите режиссеров"
        static let buttonTitle = "Продолжить"
    }
}
