//
//  AnimeListSubviews.swift
//  animatch
//
//  Created by Ксения Панкратова on 27.11.2024.
//

import SwiftUI

extension AnimeListView {
    @ViewBuilder
    var mainContent: some View {
        if viewModel.showLoading {
            loadingView
        } else {
            listContainer
        }
    }

    var loadingView: some View {
        ScrollView {
            VStack(spacing: 15) {
                ForEach(1...7, id: \.self) { _ in
                    shimmerinCellView
                }
            }
            .padding(.top, 140)
            .padding(.horizontal, 32)
        }
    }

    var shimmerinCellView: some View {
        VStack {
            NGGShimmeringView()
                .frame(height: 110)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }

    var listContainer: some View {
        ScrollView {
            LazyVStack(spacing: 15) {
                ForEach(viewModel.stories) { story in
                    OneCardView(story: story)
                        .onTapGesture {
                            viewModel.didTapCell(story: story)
                        }
                }
            }
            .padding(.top, 140)
            .padding(.horizontal, 32)
        }
        .scrollContentBackground(.hidden)
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
