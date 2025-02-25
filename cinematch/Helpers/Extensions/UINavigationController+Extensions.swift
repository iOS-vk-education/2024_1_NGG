//
//  UINavigationController+Extensions.swift
//  cinematch
//
//  Created by Ксения Панкратова on 24.12.2024.
//

import UIKit

extension UINavigationController {

    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
    }
}
