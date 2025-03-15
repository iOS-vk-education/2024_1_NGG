//
//  UIView+Extensions.swift
//  cinematch
//
//  Created by Ксения Панкратова on 11.03.2025.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
