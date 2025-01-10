import SwiftUI

struct EditPreferencesView: View {
    @State var viewModel: EditPreferencesDisplayLogic
    @Environment(Coordinator.self) var coordinator
    @State private var selectedCategory: Category = .genres

    var body: some View {
        VStack {
            categoryPicker
            ScrollView {
                if selectedCategory == .genres {
                    genresList
                } else {
                    directorsList
                }
            }
            buttonContainer
        }
        .background(backgroundLineGradient)
        .onAppear {
            UISegmentedControl.appearance().setTitleTextAttributes(
                [.foregroundColor: UIColor.white],
                for: .normal
            )
            UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.editProfPurple

            viewModel.setCoordinator(coordinator)
        }
    }
}

private extension EditPreferencesView {

    var categoryPicker: some View {
        Picker(Constants.chooseTitle, selection: $selectedCategory) {
            ForEach(Category.allCases) { category in
                Text(category.rawValue)
                    .tag(category)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
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

    var directorsList: some View {
        VStack(spacing: 12) {
            ForEach(viewModel.allDirectors, id: \.name) { director in
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

    var genresList: some View {
        VStack(spacing: 12) {
            ForEach(viewModel.allGenres, id: \.name) { genre in
                Button(action: {
                    viewModel.toggleGenreSelection(genre: genre)
                }) {
                    HStack {
                        Text(genre.name)
                            .foregroundColor(.white)
                            .font(.system(size: 18))
                        Spacer()

                        ZStack {
                            Circle()
                                .stroke(Color.gray, lineWidth: 2)
                                .frame(width: 24, height: 24)

                            if genre.isSelected {
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

    var buttonContainer: some View {
        NGGButton(Constants.buttonTitle) {
            viewModel.didTapContinue()
        }
        .padding(.horizontal)
        .padding(.bottom, 15)
    }
}

#Preview {
    EditPreferencesView(viewModel: EditPreferencesViewModelMock())
}

// MARK: - Constants

private extension EditPreferencesView {
    enum Constants {
        static let buttonTitle = "Сохранить"
        static let directorsTitle = "Режиссёры"
        static let genresTitle = "Жанры"
        static let chooseTitle = "Выбор категории"
    }
}
