//
//  MovieListSubviews.swift
//  cinematch
//
//  Created by Ксения Панкратова on 27.11.2024.
//

import SwiftUI

extension MovieListView {

    var mainContent: some View {
        ScrollView {
            if viewModel.showLoading {
                loadingView
            } else {
                listContainer
            }
        }
        .scrollContentBackground(.hidden)
    }

    var loadingView: some View {
        VStack(spacing: 15) {
            ForEach(1...7, id: \.self) { _ in
                shimmerinCellView
            }
        }
        .padding(.horizontal)
        .padding(.top)
    }

    var shimmerinCellView: some View {
        NGGShimmeringCardView()
    }

    var listContainer: some View {
        LazyVStack(spacing: 15) {
            ForEach(viewModel.stories) { story in
                OneCardView(story: story)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        viewModel.didTapCell(story: story)
                    }
            }
        }
        .padding(.horizontal, 15)
        .padding(.top)
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        MovieListView(viewModel: MovieListViewModelMock(delay:2))
    }
    .environment(StartScreenViewModel())
}

// MARK: - Constants

extension MovieListView {

    enum Constants {
        static let titleMain = "Список фильмов дня"
        static let logout = "Выйти"
    }
}
