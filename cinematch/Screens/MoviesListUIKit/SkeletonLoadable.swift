//
//  SkeletonLoadable.swift
//  cinematch
//
//  Created by Ксения Панкратова on 12.04.2025.
//

import UIKit

protocol SkeletonLoadable {}

extension SkeletonLoadable {
    func makeShimmerLayer(on view: UIView) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()

        let extraWidth = view.bounds.width
        gradientLayer.frame = CGRect(
            x: -extraWidth / 2,
            y: 0,
            width: view.bounds.width + extraWidth,
            height: view.bounds.height
        )

        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)

        gradientLayer.colors = [
            UIColor.background.cgColor,
            UIColor.cardLightGray.cgColor,
            UIColor.background.cgColor
        ]
        gradientLayer.locations = [0.0, 1.0, 2.0]
        gradientLayer.cornerRadius = view.bounds.height / 2
        gradientLayer.masksToBounds = true

        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-1.0, -0.5, 0.0]
        animation.toValue = [1.0, 1.5, 2.0]
        animation.duration = 2.0
        animation.repeatCount = .infinity
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.isRemovedOnCompletion = false

        gradientLayer.add(animation, forKey: "shimmerAnimation")

        return gradientLayer
    }
}
