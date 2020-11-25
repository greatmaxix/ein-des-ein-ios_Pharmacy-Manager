//
//  PharmacyCloseChatCollectionViewCell.swift
//  Pharmacy Manager
//
//  Created by Egor Bozko on 24.11.2020.
//  Copyright © 2020 PharmacyManager. All rights reserved.
//

import UIKit

class PharmacyCloseChatCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var messageLabel: UILabel! {
        didSet {
            messageLabel.layer.borderWidth = 1.0
            messageLabel.layer.borderColor = Asset.LegacyColors.validationRed.color.cgColor
            messageLabel.layer.cornerRadius = 8.0
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
