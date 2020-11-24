//
//  ChatRouteCollectionViewCell.swift
//  Pharmacy
//
//  Created by Egor Bozko on 03.11.2020.
//  Copyright © 2020 pharmacy. All rights reserved.
//

import UIKit

class ChatRouteCollectionViewCell: UICollectionViewCell {
   
    @IBOutlet weak var doctorBackground: UIView! {
        didSet {
            self.doctorBackground.layer.cornerRadius = self.doctorBackground.frame.height / 2
            self.doctorBackground.dropBlackShadow()
        }
    }
    @IBOutlet weak var pharmacistBackground: UIView! {
        didSet {
            self.pharmacistBackground.layer.cornerRadius = self.pharmacistBackground.frame.height / 2
            self.pharmacistBackground.dropBlackShadow()
        }
    }
    
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var pharmacistButton: UIButton!
    @IBOutlet weak var doctorButton: UIButton!
    
    var routeAction: ((ChatAPI.ChatRoute) -> Void)?
    
    private var selecetedRoute: ChatAPI.ChatRoute? {
        didSet {
            switch selecetedRoute {
            case .doctor:
                pharmacistButton.backgroundColor = .clear
                doctorButton.backgroundColor = Asset.LegacyColors.welcomeBlue.color
                confirmButton.isEnabled = true
                confirmButton.backgroundColor = Asset.LegacyColors.welcomeBlue.color
            case .pharmacist:
                pharmacistButton.backgroundColor = Asset.LegacyColors.welcomeBlue.color
                doctorButton.backgroundColor = .white
                confirmButton.isEnabled = true
                confirmButton.backgroundColor = Asset.LegacyColors.welcomeBlue.color
            case .none:
                pharmacistButton.backgroundColor = .clear
                doctorButton.backgroundColor = .clear
                confirmButton.isEnabled = false
                confirmButton.backgroundColor = .gray
            }
        }
    }
    
    @IBAction func doctorPressed(_ sender: UIButton) {
        selecetedRoute = .doctor
    }
 
    @IBAction func pharmacistPressed(_ sender: UIButton) {
        selecetedRoute = .pharmacist
    }
    
    @IBAction func confirmChoise(_ sender: Any) {
        if let r = selecetedRoute {
            routeAction?(r)
        }
    }
}
