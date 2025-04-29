//
//  Alert.swift
//  cinematch
//
//  Created by Ксения Панкратова on 12.03.2025.
//

import UIKit

extension LogInViewController {
    func presentAlert(title: String = Constants.alertTitle, message: String, isShowing: Bool) {
        if isShowing {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

            alertController.addAction(UIAlertAction(title: Constants.alertButtonTitle, style: .default) { [weak self] _ in
                guard let viewModel = self?.viewModel as? LogInViewModel else { return }
                viewModel.uiProperties.showAlert = false
                viewModel.uiProperties.errorMessage = ""
            })

            present(alertController, animated: true, completion: nil)
        }
    }
}

// MARK: - Constants

private extension LogInViewController {
    enum Constants {
        static let alertTitle = "Ошибка"
        static let alertButtonTitle = "Ок"
    }
}
