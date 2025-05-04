//
//  EditProfileViewModel.swift
//  cinematch
//
//  Created by Ксения Панкратова on 17.12.2024.
//

import FirebaseAuth
import FirebaseFirestore
import Combine
import _PhotosUI_SwiftUI

@Observable
final class EditProfileViewModel: EditProfileDisplayLogic, EditProfileViewModelInput {
    var bindingData: BindingData = BindingData()
    var isSaving: Bool = false
    var showAlert: Bool = false
    var errorMessage: String = ""

    @ObservationIgnored
    private var startScreenViewModel: StartScreenViewModel?
    @ObservationIgnored
    private var cancellables = Set<AnyCancellable>()
}

// MARK: - EditProfileViewModelInput

extension EditProfileViewModel {
    func setStartScreenViewModel(_ startScreenViewModel: StartScreenViewModel) {
        self.startScreenViewModel = startScreenViewModel
    }

    func selectedItemChange(_ newItem: PhotosPickerItem?) {
        Task {
            if let imageData = try? await newItem?.loadTransferable(type: Data.self) {
                self.bindingData.inputImage = UIImage(data: imageData)
            }
        }
    }

    func didTapSaveButton() {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        isSaving = true

        imageData()
            .flatMap { imageData in
                self.saveUserData(uid: uid, imageData: imageData)
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isSaving = false

                if case let .failure(error) = completion {
                    self?.showAlert = true
                    self?.errorMessage = "Не удалось сохранить данные"
                    print("[DEBUG] Ошибка сохранения: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] in
                self?.startScreenViewModel?.updateScreen(newScreenState: .choiceGenres)
                UserDefaults.standard.set(StartScreenState.choiceGenres.rawValue, forKey: "State")

                UserDefaults.standard.removeObject(forKey: "selectedGenres")
            }
            .store(in: &cancellables)
    }

    func validateFields() -> Bool {
        return bindingData.inputName.isEmpty || bindingData.inputSurname.isEmpty
    }
}

private extension EditProfileViewModel {
    private func imageData() -> AnyPublisher<Data?, Error> {
        guard let image = bindingData.inputImage,
              let imageData = image.jpegData(compressionQuality: 0.1)
        else {
            return Just(nil)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }

        return Just(imageData)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    private func saveUserData(uid: String, imageData: Data?) -> AnyPublisher<Void, Error> {
        let userDoc = Firestore.firestore().collection("users").document(uid)

        var data: [String: Any] = [
            "firstName": bindingData.inputName,
            "lastName": bindingData.inputSurname
        ]

        if let imageData = imageData {
            data["imageData"] = imageData.base64EncodedString()
        }

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
