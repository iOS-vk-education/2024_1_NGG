//
//  UIViewController+Extension.swift
//  cinematch
//
//  Created by Ксения Панкратова on 12.03.2025.
//

import UIKit

extension UIViewController {
    func addChildren(_ children: UIViewController...) {
        children.forEach { child in
            addChild(child)
            child.view.translatesAutoresizingMaskIntoConstraints = false
            child.didMove(toParent: self)
        }
    }
}
