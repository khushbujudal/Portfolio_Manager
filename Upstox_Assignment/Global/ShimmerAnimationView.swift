//
//  ShimmerAnimationView.swift
//  Upstox_Assignment
//
//  Created by Khushbu Judal on 22/11/24.
//

import UIKit

class ShimmerLoaderView: UIView {
    private let gradientLayer = CAGradientLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradient()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradient()
    }

    private func setupGradient() {
        gradientLayer.colors = [
            UIColor.systemGray6.cgColor,
            UIColor.systemGray4.withAlphaComponent(0.8).cgColor,
            UIColor.systemGray6.cgColor
        ]
        gradientLayer.cornerRadius = 10
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.locations = [0.0, 0.5, 1.0]
        layer.addSublayer(gradientLayer)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
//        startShimmerAnimation()
    }

    func startShimmerAnimation() {
        // Avoid adding duplicate animations
        if gradientLayer.animation(forKey: "shimmer") != nil { return }

        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-0.3, 0.0, 0.3] // Start shimmer slightly off-screen
        animation.toValue = [0.7, 1.0, 1.3]    // Move shimmer off-screen
        animation.duration = 1.5               // Smooth, slower animation
        animation.repeatCount = .infinity
        gradientLayer.add(animation, forKey: "shimmer")
    }
    func stopShimmerAnimation() {
        gradientLayer.removeAnimation(forKey: "shimmer")
    }
}
