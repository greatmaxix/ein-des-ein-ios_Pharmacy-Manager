//
//  NeedHelpViewCell.swift
//  Pharmacy Manager
//
//  Created by Sergey berdnik on 22.11.2020.
//  Copyright © 2020 PharmacyManager. All rights reserved.
//

import UIKit

class NeedHelpViewCell: ProfileBaseTableViewCell {
    
    @IBOutlet private weak var bodyTextLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setup(cellData: ProfileBaseCellData) {
        guard let data = cellData as? NeedHelpViewCellData else {return}
        
        bodyTextLabel.text = data.bodyText
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class NeedHelpViewCellData: ProfileBaseCellData {
    var bodyText: String
    
    override var nibName: String? {
        String(describing: NeedHelpViewCell.self)
    }

    override var cellHeight: CGFloat {
        UITableView.automaticDimension
    }
    
    init(bodyText: String) {
        self.bodyText = bodyText
    }
}
