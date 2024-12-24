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
                ForEach(0...4, id: \.self) { _ in
                    shimmerinCellView
                }
            }
            .padding(.top, 48)
            .padding(.horizontal, 32)
        }
        .safeAreaInset(edge: .top) {
            headerView
        }
    }

    var shimmerinCellView: some View {
        VStack {
            NGGShimmeringView()
                .frame(height: 110)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }

    var headerView: some View {
        ZStack(alignment: .center) {
            Text(Constants.titleMain)
                .font(Font.custom("Roboto", size: 24))
                .foregroundColor(Color.white)
        }
        .padding(.horizontal, 32)
        .padding(.top, 60)
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
            .padding(.top, 48)
            .padding(.horizontal, 32)
        }
        .scrollContentBackground(.hidden)
        .safeAreaInset(edge: .top) {
            headerView
        }
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
