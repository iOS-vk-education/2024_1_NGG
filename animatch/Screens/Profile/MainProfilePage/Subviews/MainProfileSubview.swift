//
//  MainProfileSubview.swift
//  animatch
//
//  Created by Ксения Панкратова on 23.12.2024.
//

import SwiftUI

extension MainProfileView {
    @ViewBuilder
    var listLoadingContent: some View {
        if viewModel.showLoading {
            loadingView
        } else {
            listContainer
        }
    }

    var loadingView: some View {
        ScrollView {
            VStack(spacing: 15) {
                ForEach(0...3, id: \.self) { _ in
                    shimmerinCellView
                }
            }
            .padding(.top, 48)
            .padding(.horizontal, 36)
        }
    }

    var shimmerinCellView: some View {
        VStack {
            NGGShimmeringView()
                .frame(height: 110)
                .clipShape(RoundedRectangle(cornerRadius: 10))
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


    var avatarView: some View {
        RoundedRectangle(cornerRadius: 30)
            .fill(Color.editProfGray)
            .frame(width: 150, height: 150)
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
            .frame(height: 166)
            ZStack {
                Text(Constants.headerTitle)
                    .font(Font.custom("Roboto", size: 20))
                HStack {
                    Spacer()
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .onTapGesture {
                            viewModel.logout()
                        }
                }
            }
            .foregroundStyle(.editProfWhite)
            .padding(.top, 65)
            .padding(.horizontal, 36)
            avatarView
                .padding(.top, 107)
        }
    }

    var textContainer: some View {
        VStack(spacing: 20) {
            ZStack {
                Text("\(viewModel.user.name) \(viewModel.user.surname)")
                    .font(Font.custom("Roboto", size: 20))

                HStack {
                    Spacer()
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .onTapGesture {
                            viewModel.logout()
                        }
                    Image(systemName: "square.and.pencil")
                        .onTapGesture {
                            viewModel.didTapEdit()
                        }
                }

            }
            .padding(.top, 10)
        }
        .foregroundColor(.white)
        .padding(.horizontal, 36)
    }

    var buttonContainer: some View {
        VStack {
            Button {
                // TODO: Добавить логику обработки нажатий
                print("[DEBUG]: редактирование предпочтений")
            } label: {
                Text(Constants.preferences)
                    .foregroundStyle(Color.editProfPurple)
                    .font(Font.custom("Roboto", size: 18))
            }
            Divider()
                .overlay(.white)
            HStack {
                Button {
                    print("[DEBUG]: избранное")
                } label: {
                    Text(Constants.addedAnime)
                }
                Spacer()
                Button {
                    print("[DEBUG]: просмотренное")
                } label: {
                    Text(Constants.viewedAnime)
                }
            }
        }
        .foregroundColor(.white)
        .padding(.horizontal, 36)
        .padding(.top, 20)
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
            .padding(.horizontal, 36)
        }
        .scrollContentBackground(.hidden)
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        MainProfileView(viewModel: MainProfileViewModelMock(delay: 2))
    }
    .environment(StartScreenViewModel())
    .environment(Coordinator())
}

// MARK: - Constants

private extension MainProfileView {

    enum Constants {
        static let headerTitle = "Профиль"
        static let addedAnime = "хочу посмотреть"
        static let viewedAnime = "просмотренные"
        static let preferences = "Мои предпочтения"
    }
}
