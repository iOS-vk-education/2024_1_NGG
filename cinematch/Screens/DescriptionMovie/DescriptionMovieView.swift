//
//  DescriptionMovieView.swift
//  cinematch
//
//  Created by Ксения Панкратова on 03.12.2024.
//

import SwiftUI

struct DescriptionMovieView: View {
    @State var viewModel: DescriptionMovieDisplayLogic & DescriptionMovieViewModelOutput
    @Environment(Coordinator.self) private var coordinator

    var body: some View {
        ScrollView {
            ImageCarouselView(images: viewModel.story)
            VStack(alignment: .leading, spacing: 24) {
                descriptionView
                CustomActionView()
                whereWatchCardView
                similarMovieListView
                buttonView
            }
            .padding(.horizontal, 34)
            .background(Color.background)
            .frame(maxWidth: .infinity)
            .clipShape(
                RoundedRectangle(cornerRadius: 40)
            )
            .padding(.top, -45)
        }
        .background(Color.background)
        .ignoresSafeArea()
//        .navigationBarBackButtonHidden()
//        .toolbar {
//            ToolbarItem(placement: .navigationBarLeading) {
//                Image(systemName: "arrow.left")
//                    .foregroundStyle(Color.white)
//                    .padding(.leading,16)
//                    .onTapGesture {
//                        coordinator.openPreviousScreen()
//                    }
//            }
//        }
        .onAppear {
            viewModel.setCoordinator(coordinator)
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack{
        DescriptionMovieView(
            viewModel: DescriptionMovieViewModelMock(story: .mockData))
    }
    .environment(Coordinator())
}
