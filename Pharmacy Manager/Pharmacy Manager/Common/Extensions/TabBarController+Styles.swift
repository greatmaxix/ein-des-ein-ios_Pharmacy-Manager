//
//  TabBarController.swift
//  Pharmacy Manager
//
//  Created by Mikhail Timoscenko on 11.09.2020.
//  Copyright © 2020 PharmacyManager. All rights reserved.
//

import Foundation
import UIKit

extension TabBarController {

    func applyStyle() {

        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()

        let cornerRadius: CGFloat = 30

        let roundedView: UIView = UIView()

        roundedView.translatesAutoresizingMaskIntoConstraints = false
        roundedView.frame = CGRect(origin: .zero, size: CGSize(width: tabBar.frame.width, height: tabBar.frame.height * 2))
        roundedView.backgroundColor = .white
        roundedView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        roundedView.layer.cornerRadius = cornerRadius
        tabBar.addSubview(roundedView)
        tabBar.sendSubviewToBack(roundedView)

        let shadowLayer = CALayer()
        shadowLayer.frame = roundedView.frame
        shadowLayer.position = roundedView.layer.position
        shadowLayer.cornerRadius = cornerRadius
        shadowLayer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        let shadowPath = UIBezierPath(roundedRect: tabBar.bounds, cornerRadius: cornerRadius)

        shadowLayer.shadowPath = shadowPath.cgPath
        shadowLayer.backgroundColor = UIColor.white.cgColor

        shadowLayer.shadowColor = Asset.Colors.appBlueDark.color.withAlphaComponent(0.06).cgColor
        shadowLayer.shadowOpacity = 1
        shadowLayer.shadowRadius = 10
        shadowLayer.shadowOffset = CGSize(width: 0, height: -4)

        roundedView.layer.insertSublayer(shadowLayer, at: 0)

        NSLayoutConstraint.activate([
            roundedView.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor),
            roundedView.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor),
            roundedView.topAnchor.constraint(equalTo: tabBar.topAnchor),
            roundedView.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor)
        ])
    }

}
