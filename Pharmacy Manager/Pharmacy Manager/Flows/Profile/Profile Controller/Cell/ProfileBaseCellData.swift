//
//  ProfileBaseCellData.swift
//  Pharmacy Manager
//
//  Created by Sergey berdnik on 19.11.2020.
//  Copyright © 2020 PharmacyManager. All rights reserved.
//

import UIKit

class ProfileBaseCellData {
    
    var selectHandler: (() -> Void)?
    
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
    
    func setup(cellData: ProfileBaseCellData) {
        
    }
    
    func disactivateCell() {
        
    }
    
    func setup(representObj: Any) {
        
    }

}
