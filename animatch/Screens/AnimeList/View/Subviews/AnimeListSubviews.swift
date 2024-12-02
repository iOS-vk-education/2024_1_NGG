//
//  AnimeListSubviews.swift
//  animatch
//
//  Created by Ксения Панкратова on 27.11.2024.
//

import SwiftUI

extension AnimeListView {

    var headerView: some View {
        ZStack(alignment: .center) {
            Text(Constants.titleMain)
                .font(Font.custom("Roboto", size: 24))
                .foregroundColor(Color.white)

            HStack {
                Button {
                    // TODO: IOS-: Добавить логику обработки нажатий
                    print("[DEBUG]: Назад")
                } label: {
                    Image(systemName: "arrow.left")
                        .font(Font.custom("Roboto", size: 24))
                        .foregroundColor(Color.white)
                }
                Spacer()
                Image(systemName: "person.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .background(Color.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
        .padding(.horizontal, 32)
        .padding(.top, 60)
    }

    var listContainer: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.stories) { story in
                    OneCardView(story: OneCardModel(story: story))
                        .padding(.bottom, 15)
                        .onAppear {
                            print("[DEBUG]: я тут")
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
        AnimeListView(viewModel: .mockData)
    }
}

// MARK: - Constants

private extension AnimeListView {

    enum Constants {
        static let titleMain = "Список аниме дня"
    }
}
