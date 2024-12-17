//
//  EditProfileViewModel.swift
//  animatch
//
//  Created by Ксения Панкратова on 17.12.2024.
//

import Foundation

final class EditProfileViewModel: EditProfileViewModelLogic & EditProfileViewModelInput {
    @Published var inputName = ""
    @Published var inputSurname = ""
    @Published var inputEmail = ""
    
    @ObservationIgnored
    private var coordinator: Coordinator?

    func setCoordinator(_ coordinator: Coordinator) {
        self.coordinator = coordinator
    }

    func didTapContinue(to screen: AppScreens) {
        coordinator?.addScreen(screen: screen)
    }
}
