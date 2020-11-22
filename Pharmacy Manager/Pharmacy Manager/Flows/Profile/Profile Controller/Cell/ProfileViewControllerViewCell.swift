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
        selectionStyle = .none
    }
    
    override func setup(cellData: ProfileBaseCellData) {
        
        guard let data = cellData as? ProfileViewControllerCellData else {return}
        
        cellTypeImageView.image = UIImage(named: data.imageName)?.withRenderingMode(.alwaysTemplate)
        titleLabel.text = data.title
        
        if let color = data.tintColor {

            self.titleLabel.textColor = color
            self.cellTypeImageView.backgroundColor = color.withAlphaComponent(0.2)
            
        }
    }
    
    override func disactivateCell() {
        contentBackgroundView.alpha = 0.5
        isUserInteractionEnabled = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: - Structure for cell data creating
class ProfileViewControllerCellData: ProfileBaseCellData {
    
    var imageName: String
    var title: String
    var tintColor: UIColor?
    
    override var cellHeight: CGFloat {
         70
    }
    
    override var nibName: String? {
         String(describing: ProfileViewControllerViewCell.self)
    }
    
    /**
            Setup cells view
            - Parameter imageName: enter image name from Assets
            - Parameter title: enter String to set cell title
            - Parameter tintColor: change color for Title label and Image background
     */
    init(imageName: String, title: String,
         tintColor: UIColor? = nil) {
        self.title = title
        self.imageName = imageName
        self.tintColor = tintColor
    }
}
