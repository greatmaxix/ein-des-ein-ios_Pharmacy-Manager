//
//  ProfileViewControllerViewCell.swift
//  Pharmacy Manager
//
//  Created by Sergey berdnik on 19.11.2020.
//  Copyright © 2020 PharmacyManager. All rights reserved.
//

import UIKit

class ProfileViewControllerViewCell: ProfileBaseTableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var cellTypeImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var contentBackgroundView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        contentBackgroundView.layer.cornerRadius = 8
        contentBackgroundView.cellLightBlueShadow()
        cellTypeImageView.layer.cornerRadius = cellTypeImageView.frame.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func setup(cellData: ProfileBaseCellData) {
        
        guard let data = cellData as? ProfileViewControllerCellData else {return}
        
        cellTypeImageView.image = UIImage(named: data.imageName)
        titleLabel.text = data.title
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: - Structure for cell data creating
class ProfileViewControllerCellData: ProfileBaseCellData {
    var imageName: String
    var title: String
    
    override var cellHeight: CGFloat {
         70
    }
    
    override var nibName: String? {
         String(describing: ProfileViewControllerViewCell.self)
    }
    
    init(imageName: String, title: String) {
        self.title = title
        self.imageName = imageName
    }
}
