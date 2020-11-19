//
//  EmptyTableViewCell.swift
//  Pharmacy Manager
//
//  Created by Sergey berdnik on 19.11.2020.
//  Copyright © 2020 PharmacyManager. All rights reserved.
//

import UIKit

class EmptyTableViewCell: ProfileBaseTableViewCell {

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        selectionStyle = .none
    }
    
    override func setup(cellData: ProfileBaseCellData) {
        if let cd: EmptyTableViewCellData = cellData as? EmptyTableViewCellData {
            backgroundColor = cd.color
        }
    }
}


class EmptyTableViewCellData: ProfileBaseCellData {
    
    override var nibName: String? {
        String(describing: EmptyTableViewCell.self)
    }
    override var cellHeight: CGFloat {
        height
    }
    
    init(height: CGFloat = 0, color: UIColor? = nil) {
        self.height = height
        self.color = color
    }
    
    var height: CGFloat = 0
    var color: UIColor?
}

