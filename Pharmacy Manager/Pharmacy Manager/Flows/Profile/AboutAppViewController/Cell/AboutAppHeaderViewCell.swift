//
//  AboutAppHeaderViewCell.swift
//  Pharmacy Manager
//
//  Created by Sergey berdnik on 20.11.2020.
//  Copyright © 2020 PharmacyManager. All rights reserved.
//

import UIKit

class AboutAppHeaderViewCell: ProfileBaseTableViewCell {
    
    @IBOutlet private weak var urlLabel: UILabel!
    
    var urlTappedActionHandler: EmptyClosure?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    override func setup(cellData: ProfileBaseCellData) {
        setupGestures()
    }
    
    private func setupGestures() {
        urlLabel.isUserInteractionEnabled = true
        let tapAction = UITapGestureRecognizer(target: self, action: #selector(actionTapped))
        urlLabel.addGestureRecognizer(tapAction)
    }
    
    @objc func actionTapped() {
        self.urlTappedActionHandler?()
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
