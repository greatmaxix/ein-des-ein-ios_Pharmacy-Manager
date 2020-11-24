//
//  UIView+Shadow.swift
//  Pharmacy
//
//  Created by CGI-Kite on 25.06.2020.
//  Copyright © 2020 pharmacy. All rights reserved.
//

import UIKit

extension UIView {
    
    func dropShadow(scale: Bool = true, color: UIColor?, width: CGFloat =  1, height: CGFloat = 1, radius: CGFloat = 1, opacity: Float) {
        layer.masksToBounds = false
        layer.shadowColor = color?.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = CGSize(width: width, height: height)
        layer.shadowRadius = radius
        
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func dropBlueShadow() {
        dropShadow(scale: true, color: Asset.LegacyColors.shadowBlue.color, width: 0, height: 6, radius: 8, opacity: 0.1)
    }

    func dropBlueShadowCart() {
        dropShadow(scale: true, color: Asset.LegacyColors.shadowBlue.color, width: 1, height: 1, radius: 8, opacity: 0.1)
    }
    
    func bottomViewDropGrayShadow() {
        dropShadow(scale: true, color: Asset.LegacyColors.gray.color, width: 0, height: -4, radius: 8, opacity: 0.1)
    }
    
    func buttonDropBlueShadow() {
        dropShadow(scale: true, color: Asset.LegacyColors.shadowBlue.color, width: 0, height: 4, radius: 20, opacity: 0.1)
    }
    
    func dropLightBlueShadow() {
        dropShadow(scale: true, color: Asset.LegacyColors.lightBlue.color, width: 0, height: 6, radius: 8, opacity: 0.1)
    }

    func dropCellLightBlueShadow() {
        dropShadow(scale: true, color: Asset.LegacyColors.lightBlue.color, width: 1, height: 1, radius: 8, opacity: 0.1)
    }
  
    func cellLightBlueShadow() {
        dropShadow(scale: true, color: Asset.LegacyColors.lightBlue.color, width: 0, height: 0, radius: 2, opacity: 0.1)
    }
    
    func dropBlackShadow() {
        dropShadow(scale: true, color: .black, width: 0, height: 1, radius: 2, opacity: 0.2)
    }
    
    func dropInputBarShadow() {
        dropShadow(scale: true, color: .black, width: 0, height: 2, radius: 2, opacity: 0.2)
    }
    
    func removeShadow() {
        layer.shadowColor = nil
        layer.shadowOpacity = 0
        layer.shadowOffset = CGSize(width: 0, height: -3)
    }
}
