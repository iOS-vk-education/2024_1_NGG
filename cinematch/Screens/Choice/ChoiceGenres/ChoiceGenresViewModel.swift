//
//  ChoiceGenresViewModel.swift
//  cinematch
//
//  Created by Ксения Панкратова on 18.12.2024.
//

import Foundation
import Combine
import FirebaseAuth
import FirebaseFirestore

struct GenreResponse: Decodable {
    var name: String
}

@Observable
final class ChoiceGenresViewModel: ChoiceGenresDisplayLogic {
    var genres: [Genre] = []
    var uiProperties = ChoiceGenresModel.UIProperties()

    private let networkService: MovieListNetworkProtocol

    @ObservationIgnored
    private var coordinator: Coordinator?
    @ObservationIgnored
    private var startScreenViewModel: StartScreenViewModel?

    private var cancellables = Set<AnyCancellable>()

    init(networkService: MovieListNetworkProtocol = Network()) {
        self.networkService = networkService
    }

    var anyGenreSelected: Bool {
        genres.contains { $0.isSelected }
    }

    func toggleGenreSelection(genre: Genre) {
        if let index = genres.firstIndex(where: { $0.name == genre.name }) {
            genres[index].isSelected.toggle()

            var savedGenres = UserDefaults.standard.stringArray(forKey: "selectedGenres") ?? []

            if genres[index].isSelected {
                savedGenres.append(genres[index].name)
            } else {
                savedGenres.removeAll { $0 == genres[index].name }
            }
            UserDefaults.standard.set(savedGenres, forKey: "selectedGenres")
        }
    }
}

extension ChoiceGenresViewModel {
    func setCoordinator(_ coordinator: Coordinator) {
        self.coordinator = coordinator
    }

    func setStartScreenViewModel(_ startScreenViewModel: StartScreenViewModel) {
        self.startScreenViewModel = startScreenViewModel
    }

    func fetchGenres() {
        networkService.fetchAllGenresPublisher()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }

                if case .failure(_) = completion {
                    self.uiProperties.showAlert = true
                    self.uiProperties.errorMessage = Constants.notLoadError
                }
            } receiveValue: { [weak self] genres in
                guard let self = self else { return }

                self.genres = genres.map { Genre(name: $0.name, isSelected: false) }
            }
            .store(in: &cancellables)
    }

    func didTapContinue() {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        saveGenres(uid: uid)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }

                if case .failure(_) = completion {
                    self.uiProperties.showAlert = true
                    self.uiProperties.errorMessage = Constants.notSavedError
                }
            } receiveValue: { [weak self] in
                guard let self = self else { return }

                self.startScreenViewModel?.updateScreen(newScreenState: .choiceGenres)
                UserDefaults.standard.set(StartScreenState.choiceGenres.rawValue, forKey: "State")

                self.coordinator?.addScreen(screen: PreferenceScreens.directors)
                UserDefaults.standard.removeObject(forKey: "selectedDirectors")
            }
            .store(in: &cancellables)
    }

    func saveGenres(uid: String) -> AnyPublisher<Void, Error> {
        let userDoc = Firestore.firestore().collection("users").document(uid)

        let selectedGenres = genres
            .filter { $0.isSelected }
            .map { $0.name }

        let data: [String: Any] = ["genres": selectedGenres]

        return Future<Void, Error> { promise in
            userDoc.setData(data, merge: true) { error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(()))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}

extension ChoiceGenresViewModel {
    enum Constants {
        static let notLoadError = "Не удалось загрузить жанры"
        static let notSavedError = "Не удалось сохранить жанры"
    }
}
