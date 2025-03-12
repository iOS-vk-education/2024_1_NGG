//
//  KeyBoard.swift
//  cinematch
//
//  Created by Ксения Панкратова on 12.03.2025.
//

import UIKit

extension LogInViewController {
    func setupKeyboard() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(gestureRecognizer)

        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc
    private func keyBoardWillShow(notification: NSNotification) {
        let keyboardHeight = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height

        scrollView.contentInset = UIEdgeInsets(
            top: view.safeAreaInsets.top,
            left: 0,
            bottom: keyboardHeight + view.safeAreaInsets.bottom,
            right: 0)
    }

    @objc
    private func keyBoardWillHide(notification: NSNotification) {
        scrollView.contentInset = UIEdgeInsets(top: view.safeAreaInsets.top, left: 0, bottom: view.safeAreaInsets.bottom, right: 0)
    }

    @objc
    private func viewTapped() {
        view.endEditing(true)
    }
}
