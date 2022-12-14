//
//  ProfileBaseCellData.swift
//  Pharmacy Manager
//
//  Created by Sergey berdnik on 19.11.2020.
//  Copyright © 2020 PharmacyManager. All rights reserved.
//

import UIKit

class ProfileBaseCellData {
    
    var selectHandler: EmptyClosure?
    
    var nibName: String? {
         nil
    }

    var cellHeight: CGFloat {
        40
    }
    
    var separatorStyle: UITableViewCell.SeparatorStyle {
        
        .none
    }
}

class ProfileBaseTableViewCell: UITableViewCell {
    
    var isApplyState: Bool = false
    func setup(cellData: ProfileBaseCellData) {}
    func deactivateCell() {}
    func defaultCellState() {}
    func applyCellState() {}
    func setup(representObj: Any) {}
}
