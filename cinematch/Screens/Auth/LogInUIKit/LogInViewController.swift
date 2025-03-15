//
//  LogInViewController.swift
//  cinematch
//
//  Created by Ксения Панкратова on 09.03.2025.
//

import Foundation
import UIKit
import SwiftUI

final class LogInViewController: UIViewController {
    private var viewModel: LogInViewModelLogic

    // MARK: - UI Elements

    private let screenTitle = UILabel()
    private let regButton = UIButton()
    private let divider = UIView()
    private let textLabel = UILabel()
    let scrollView: UIScrollView = UIScrollView()
    private let containerView: UIView = UIView()

    private lazy var emailTextField: UIHostingController<NGGTextField> = {
        return UIHostingController(
            rootView: NGGTextField(
                title: Constants.nameTextFieldPlaceholder,
                text: Binding(
                    get: { [weak self] in self?.viewModel.email ?? "" },
                    set: { [weak self] in self?.viewModel.email = $0 }
                )
            )
        )
    }()

    private lazy var passwordTextField: UIHostingController<NGGSecureField> = {
        return UIHostingController(
            rootView: NGGSecureField(
                Constants.passwordTextFieldPlaceholder,
                text: Binding(
                    get: { [weak self] in self?.viewModel.password ?? "" },
                    set: { [weak self] in self?.viewModel.password = $0 }
                )
            )
        )
    }()

    private lazy var logInButton: UIHostingController<NGGButton> = {
        return UIHostingController(rootView: NGGButton(Constants.continueButtonTitle) {
            [weak self] in self?.didTapLogInButton()
        })
    }()

    private lazy var stackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()

    init(viewModel: LogInViewModelLogic) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
        setupKeyboard()
    }
}

private extension LogInViewController {
    func setupUI() {
        view.backgroundColor = UIColor(.background)

        screenTitle.text = Constants.formsContainerTitle
        screenTitle.textColor = .white
        screenTitle.font = .systemFont(ofSize: 32, weight: .semibold)
        screenTitle.textAlignment = .center

        emailTextField.view.backgroundColor = .clear

        passwordTextField.view.backgroundColor = .clear

        divider.backgroundColor = .white
        divider.alpha = 0.7

        logInButton.view.backgroundColor = .clear

        let attributedTitle = NSAttributedString(
            string: Constants.singupButton,
            attributes: [
                .underlineStyle: NSUnderlineStyle.single.rawValue,
                .foregroundColor: UIColor.editProfPurple,
                .font: UIFont.systemFont(ofSize: 16)
            ]
        )

        regButton.setAttributedTitle(attributedTitle, for: .normal)
        regButton.addTarget(self, action: #selector(didTapRegistration), for: .touchUpInside)

        textLabel.text = Constants.footerText
        textLabel.textColor = .white
        textLabel.font = .systemFont(ofSize: 16)

        stackView.addArrangedSubview(textLabel)
        stackView.addArrangedSubview(regButton)

        scrollView.contentInsetAdjustmentBehavior = .never

        view.addSubviews(scrollView)
        scrollView.addSubviews(containerView)
        addChildren(emailTextField, passwordTextField, logInButton)
        containerView.addSubviews(screenTitle, divider, stackView, emailTextField.view, passwordTextField.view, logInButton.view)
    }

    func setupLayout() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),

            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0),
            containerView.widthAnchor.constraint(equalTo: view.widthAnchor),

            screenTitle.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 275),
            screenTitle.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),

            emailTextField.view.topAnchor.constraint(equalTo: screenTitle.bottomAnchor, constant: 55),
            emailTextField.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 60),
            emailTextField.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -60),

            passwordTextField.view.topAnchor.constraint(equalTo: emailTextField.view.bottomAnchor),
            passwordTextField.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 60),
            passwordTextField.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -60),

            logInButton.view.topAnchor.constraint(equalTo: passwordTextField.view.bottomAnchor, constant: 5),
            logInButton.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 60),
            logInButton.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -60),

            divider.topAnchor.constraint(equalTo: logInButton.view.bottomAnchor, constant: 105),
            divider.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 40),
            divider.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -40),
            divider.heightAnchor.constraint(equalToConstant: 0.8),

            stackView.topAnchor.constraint(equalTo: divider.bottomAnchor),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            stackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
    }
}

// MARK: - Actions

@objc
private extension LogInViewController {
    func didTapLogInButton() {
        viewModel.validateData()
        guard viewModel.showAlert else { return }
        presentAlert(message: Constants.errorMessage)
    }

    func didTapRegistration() {
        viewModel.didTapOpenRegistrationScreen()
    }
}

// MARK: - Constants

private extension LogInViewController {
    enum Constants {
        static let formsContainerTitle = "Вход"
        static let nameTextFieldPlaceholder = "email"
        static let passwordTextFieldPlaceholder = "password"
        static let continueButtonTitle = "Продолжить"
        static let footerText = "Нет аккаунта? "
        static let singupButton = "Зарегистрируйтесь"
        static let errorMessage = "Неверный email или пароль. Пожалуйста, попробуйте снова."
    }
}
