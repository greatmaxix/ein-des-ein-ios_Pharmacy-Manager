//
//  UIView.swift
//  KyivPost
//
//  Created by Anton Bal’ on 09.07.2020.
//  Copyright © 2020 KyivPost. All rights reserved.
//

import UIKit

struct Shadow {
    let offset: CGSize
    let radius: CGFloat
    let opacity: Float
    let color: UIColor
}

extension UIView {
    func add(shadow: Shadow) {
        layer.shadowOffset = shadow.offset
        layer.shadowRadius = shadow.radius
        layer.shadowOpacity = shadow.opacity
        layer.shadowColor = shadow.color.cgColor
        clipsToBounds = false
    }
    func deleteShadow() {
        layer.shadowOffset = .zero
        layer.shadowRadius = 0
        layer.shadowOpacity = 0
        layer.shadowColor = nil
        clipsToBounds = true
    }
}

extension UIView {
    func constraintsToSuperView(insets: UIEdgeInsets = .zero) {
        guard let superview = superview else { return }
        
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: insets.right),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.left),
            topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: insets.bottom),
        ])
    }
    
    func constraintsToSafeArea(insets: UIEdgeInsets = .zero) {
        guard let superview = superview else { return }
        
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor, constant: insets.right),
            safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor, constant: insets.left),
            safeAreaLayoutGuide.topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: insets.top),
            safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor, constant: insets.bottom),
        ])
    }
}
