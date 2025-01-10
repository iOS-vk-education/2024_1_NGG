//
//  PreferencesView.swift
//  animatch
//
//  Created by Ксения Панкратова on 03.01.2025.
//

import SwiftUI

struct PreferencesView: View {
    @State var viewModel: PreferencesDisplayLogic
    @Environment(Coordinator.self) private var coordinator

    var body: some View {
        VStack {
            List {
                genresSection
                directorsSection
            }
            buttonContainer
        }
        .scrollContentBackground(.hidden)
        .onAppear {
            viewModel.setCoordinator(coordinator)
            viewModel.reloadData()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(Constants.title)
        .background(backgroundLineGradient)
    }
}

private extension PreferencesView {

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

    var genresSection: some View {
        Section(
            header: Text(Constants.genres)
                .foregroundColor(Color.gray)
        ) {
            ForEach(viewModel.genres, id: \.self) { name in
                Text(name)
                    .listRowBackground(Color.clear)
            }
        }
        .foregroundColor(Color.white)
    }

    var directorsSection: some View {
        Section(
            header: Text(Constants.directors)
                .foregroundColor(Color.gray)
        ) {
            ForEach(viewModel.directors, id: \.self) { name in
                Text(name)
                    .listRowBackground(Color.clear)
            }
        }
        .foregroundColor(Color.white)
    }

    var buttonContainer: some View {
        NGGButton(Constants.buttonTitle) {
            viewModel.didTapEdit()
        }
        .listRowBackground(Color.clear)
        .padding(.horizontal, 40)
    }
}

// MARK: - Preview

#Preview {
    PreferencesView(viewModel: PreferencesViewModelMock())
        .environment(Coordinator())
}

// MARK: - Constants

private extension PreferencesView {
    enum Constants {
        static let genres = "Жанры"
        static let directors = "Режиссеры"
        static let title = "Предпочтения"
        static let buttonTitle = "Изменить"
    }
}
