//
//  AnimeListSubviews.swift
//  animatch
//
//  Created by Ксения Панкратова on 27.11.2024.
//

import SwiftUI

extension AnimeListView {

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
            ForEach(1...5, id: \.self) { _ in
                shimmerinCellView
            }
        }
        .padding(.horizontal)
        .padding(.top)
    }

    var shimmerinCellView: some View {
        NGGShimmeringView()
            .frame(height: 110)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }

    var listContainer: some View {
        LazyVStack(spacing: 15) {
            ForEach(viewModel.stories) { story in
                OneCardView(story: story)
                    .onTapGesture {
                        viewModel.didTapCell(story: story)
                    }
            }
        }
        .padding(.horizontal)
        .padding(.top)
    }

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
}

// MARK: - Preview

#Preview {
    NavigationStack {
        AnimeListView(viewModel: AnimeListViewModelMock(delay:2))
    }
    .environment(StartScreenViewModel())
}

// MARK: - Constants

extension AnimeListView {

    enum Constants {
        static let titleMain = "Список аниме дня"
        static let logout = "Выйти"
    }
}
