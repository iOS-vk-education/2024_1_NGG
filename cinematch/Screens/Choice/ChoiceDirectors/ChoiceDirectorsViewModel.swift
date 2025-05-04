//
//  ChoiceDirectorsViewModel.swift
//  cinematch
//
//  Created by Ксения Панкратова on 18.12.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import Combine

@Observable
final class ChoiceDirectorsViewModel: ChoiceDirectorsViewModelLogic {
    private(set) var directors: [Directors] = []
    var uiProperties = ChoiceDirectorsModel.UIProperties()

    @ObservationIgnored
    private let networkService: MovieListNetworkProtocol

    @ObservationIgnored
    private var startScreenViewModel: StartScreenViewModel?
    @ObservationIgnored
    private var coordinator: Coordinator?
    @ObservationIgnored
    private var cancellables = Set<AnyCancellable>()

    init(networkService: MovieListNetworkProtocol = Network()) {
        self.networkService = networkService
        directors = Data.popularDirectors
    }

    var anyDirectorSelected: Bool {
        directors.contains { $0.isSelected }
    }

    func toggleDirectorSelection(director: Directors) {
        guard let index = directors.firstIndex(where: { $0.id == director.id }) else { return }

        directors[index].isSelected.toggle()

        var saved = UserDefaults.standard.stringArray(forKey: "selectedDirectors") ?? []

        if directors[index].isSelected {
            saved.append(directors[index].name)
        }
        else {
            saved.removeAll { $0 == directors[index].name }
        }
        UserDefaults.standard.set(saved, forKey: "selectedDirectors")
    }
}

extension ChoiceDirectorsViewModel {
    func setCoordinator(_ coordinator: Coordinator) {
        self.coordinator = coordinator
    }

    func setStartScreenViewModel(_ startScreenViewModel: StartScreenViewModel) {
        self.startScreenViewModel = startScreenViewModel
    }

    func didTapContinue() {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        saveDirectors(uid: uid)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }

                if case .failure(_) = completion {
                    self.uiProperties.showAlert = true
                    self.uiProperties.errorMessage = Constants.notSavedError
                }
            } receiveValue: { [weak self] in
                guard let self = self else { return }

                self.startScreenViewModel?.updateScreen(newScreenState: .movieList)
                if let state = self.startScreenViewModel?.currentScreenState {
                    UserDefaults.standard.set(state.rawValue, forKey: "State")
                }
            }
            .store(in: &cancellables)
    }

    func saveDirectors(uid: String) -> AnyPublisher<Void, Error> {
        let userDoc = Firestore.firestore().collection("users").document(uid)

        let selectedDirectors = directors
            .filter { $0.isSelected }
            .map { ["id": $0.id, "name": $0.name] }

        let data: [String: Any] = ["directors": selectedDirectors]

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

// MARK: - Constants

private extension ChoiceDirectorsViewModel {
    enum Data {
        static let popularDirectors = [
            Directors(id: 41477, name: "Кристофер Нолан", isSelected: false),
            Directors(id: 7640, name: "Квентин Тарантино", isSelected: false),
            Directors(id: 22260, name: "Стивен Спилберг", isSelected: false),
            Directors(id: 1190, name: "Мартин Скорсезе", isSelected: false),
            Directors(id: 10988, name: "Андрей Тарковский", isSelected: false),
            Directors(id: 493688, name: "Пон Чжун Хо", isSelected: false),
            Directors(id: 47753, name: "Хаяо Миядзаки", isSelected: false),
            Directors(id: 27977, name: "Джеймс Кэмерон", isSelected: false),
            Directors(id: 21459, name: "Тим Бёртон", isSelected: false)
        ]
    }

    enum Constants {
        static let notSavedError = "Не удалось сохранить режиссеров"
    }
}
