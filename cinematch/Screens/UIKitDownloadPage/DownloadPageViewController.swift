//
//  DownloadPageViewController.swift
//  cinematch
//
//  Created by Ксения Панкратова on 13.01.2025.
//

import UIKit
import SwiftUI

final class DownloadPageViewController: UIViewController {

    private let viewModel: DownloadPageInput

    private let logo = UIHostingController(rootView: NGGLogoView())

    private let logInButton = UIButton()
    private let registrationButton = UIButton()

    init(viewModel: DownloadPageInput) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
    }
}

// MARK: - UI

private extension DownloadPageViewController {
   func setupUI() {
        view.backgroundColor = UIColor(.background)

        logo.view.backgroundColor = .clear
        addChild(logo)
        logo.didMove(toParent: self)
        view.addSubview(logo.view)

        setupButton(logInButton, title: Constants.logInButtonTitle, backgroundColor: .editProfPurple)
        logInButton.addTarget(self, action: #selector(didTapLogInButton), for: .touchUpInside)
        view.addSubview(logInButton)

        setupButton(registrationButton, title: Constants.registrationButtonTitle, backgroundColor: .textFieldGray)
        registrationButton.addTarget(self, action: #selector(didTapRegistrationButton), for: .touchUpInside)
        view.addSubview(registrationButton)
    }

   func setupButton(_ button: UIButton, title: String, backgroundColor: UIColor) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
    }
}

// MARK: - Layout Setup

private extension DownloadPageViewController {
    func setupLayout() {
        logo.view.translatesAutoresizingMaskIntoConstraints = false
        logo.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        logo.view.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        logInButton.translatesAutoresizingMaskIntoConstraints = false
        logInButton.topAnchor.constraint(equalTo: logo.view.bottomAnchor, constant: 20).isActive = true
        logInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60).isActive = true
        logInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60).isActive = true
        logInButton.heightAnchor.constraint(equalToConstant: 50).isActive = true

        registrationButton.translatesAutoresizingMaskIntoConstraints = false
        registrationButton.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 16).isActive = true
        registrationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60).isActive = true
        registrationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60).isActive = true
        registrationButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}

// MARK: - Actions

@objc
private extension DownloadPageViewController {
    func didTapLogInButton() {
        viewModel.didTapLogIn()
    }

    func didTapRegistrationButton() {
        viewModel.didTapRegister()
    }
}

// MARK: - Constants

private extension DownloadPageViewController {
    enum Constants {
        static let logInButtonTitle = "Вход"
        static let registrationButtonTitle = "Регистрация"
    }
}
