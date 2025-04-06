//
//  PreferencesView.swift
//  cinematch
//
//  Created by Ксения Панкратова on 03.01.2025.
//

import SwiftUI

struct PreferencesView: View {
    @State var viewModel: PreferencesDisplayLogic
    @Environment(NavigationControllerCoordinator.self) private var coordinator

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
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItems
        }
        .background(Color.background)
    }
}

private extension PreferencesView {
    @ToolbarContentBuilder
    var ToolbarItems: some ToolbarContent {
        ToolbarItem(placement: .principal) {
            Text(Constants.title)
                .font(Font.custom("Roboto", size: 22))
                .foregroundColor(.white)
        }

        ToolbarItem(placement: .navigationBarLeading) {
            Image(systemName: "arrow.left")
                .foregroundStyle(Color.white)
                .onTapGesture {
                    coordinator.openPreviousScreen()
                }
        }
    }

    var genresSection: some View {
        Section(
            header: Text(Constants.genres)
                .foregroundColor(Color.gray)
        ) {
            ForEach(viewModel.genres, id: \.self) { name in
                Text(name)
                    .font(Font.custom("Roboto", size: 16))
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
                    .font(Font.custom("Roboto", size: 16))
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
        .environment(NavigationControllerCoordinator())
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
