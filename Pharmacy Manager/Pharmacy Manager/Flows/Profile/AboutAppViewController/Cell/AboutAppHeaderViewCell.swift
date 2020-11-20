//
//  AboutAppHeaderViewCell.swift
//  Pharmacy Manager
//
//  Created by Sergey berdnik on 20.11.2020.
//  Copyright © 2020 PharmacyManager. All rights reserved.
//

import UIKit

class AboutAppHeaderViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
}

// MARK: - Structure for cell data creating
class AboutAppHeaderViewCellData: ProfileBaseCellData {
    
    override var nibName: String? {
        String(describing: AboutAppHeaderViewCell.self)
    }

    override var cellHeight: CGFloat {
        110
    }
}
