//
//  LogInAssembler.swift
//  cinematch
//
//  Created by Ксения Панкратова on 16.03.2025.
//

import Foundation

final class LogInAssembler {
    static func assemble() -> LogInViewModel {
        let viewModel = LogInViewModel()
        let worker = LogInWorker()
        let interactor = LogInInteractor(worker: worker)
        let presenter = LogInPresenter()
        interactor.presenter = presenter
        viewModel.interactor = interactor
        presenter.viewModel = viewModel
        return viewModel
    }
}
