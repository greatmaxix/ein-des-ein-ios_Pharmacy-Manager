//
//  LastRecommendedView.swift
//  Pharmacy Manager
//
//  Created by Sergey berdnik on 25.11.2020.
//  Copyright © 2020 PharmacyManager. All rights reserved.
//

import UIKit

class LastRecommendedView: UIView {
    let CONTENT_XIB_NAME = "LastRecommendedView"
        
    // MARK: - @IBOutlets & Properties
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var medicineImageView: UIImageView!
    @IBOutlet private weak var medicineNameLabel: UILabel!
    @IBOutlet private weak var releaseFormLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    
    private var tapActionHandler: EmptyClosure?

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(CONTENT_XIB_NAME, owner: self, options: nil)
        contentView.fixInView(self)
    }
    
    func setupView(item: LastProducts) {
        if let url = URL(string: item.pictureUrls.first ?? "") {
            medicineImageView.loadImageBy(url: url)
        }
        medicineNameLabel.text = item.productName.htmlToString
        releaseFormLabel.text = item.releaseForm.htmlToString
        priceLabel.text = item.minPrice?.moneyString(with: "₸") ?? "-"
    }
}
