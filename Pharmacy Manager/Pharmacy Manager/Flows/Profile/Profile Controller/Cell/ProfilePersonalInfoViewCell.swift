//
//  ProfilePersonalInfoViewCell.swift
//  Pharmacy Manager
//
//  Created by Sergey berdnik on 19.11.2020.
//  Copyright © 2020 PharmacyManager. All rights reserved.
//

import UIKit

class ProfilePersonalInfoViewCell: ProfileBaseTableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var customerImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        customerImageView.layer.cornerRadius = customerImageView.frame.width / 2
        selectionStyle = .none
    }
    
    // MARK: - Setup cell func
    override func setup(cellData: ProfileBaseCellData) {
        
        guard let data = cellData as? ProfilePersonalInfoData else {return}
        
        if let url = data.imageUrl {
            customerImageView.loadImageBy(url: url)
        }
        nameLabel.text = data.name
        emailLabel.text = data.email
        
        if let score = data.score, !score.isEmpty {
            scoreLabel.text = score + " ⭐️"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


// MARK: - Structure for cell data creating
class ProfilePersonalInfoData: ProfileBaseCellData {
    var imageUrl: URL?
    var name: String
    var email: String
    var score: String?
    
    override var nibName: String? {
        String(describing: ProfilePersonalInfoViewCell.self)
    }

    override var cellHeight: CGFloat {
        105
    }
    
    init(imageUrl: URL?, name: String, email: String, score: String?) {
        self.imageUrl = imageUrl
        self.name = name
        self.email = email
        self.score = score
    }
}
