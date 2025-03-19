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
        let interactor = LogInInteractor()
        let presenter = LogInPresenter()
        let worker = LogInWorker()
        interactor.worker = worker
        interactor.presenter = presenter
        viewModel.interactor = interactor
        presenter.viewModel = viewModel
        return viewModel
    }
}
