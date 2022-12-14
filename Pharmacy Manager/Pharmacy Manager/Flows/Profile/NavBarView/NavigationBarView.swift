//
//  NavigationBarView.swift
//  Pharmacy Manager
//
//  Created by Sergey berdnik on 24.11.2020.
//  Copyright © 2020 PharmacyManager. All rights reserved.
//

import UIKit


@available(*, deprecated, message: "not used")
class NavigationBarView: UIView {
    let CONTENT_XIB_NAME = "NavigationBarView"
    
    // MARK: - @IBOutlets & Properties
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var titleLabel: UILabel!
    
    private var backButtonHandler: EmptyClosure?
    
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
    
    func setupBar(backButtonText: String, titleText: String, backButtonAction: EmptyClosure? = nil) {
        self.titleLabel.text = titleText
        self.backButton.setTitle(backButtonText, for: .normal)
        self.backButtonHandler = backButtonAction
    }
    
    func backButtonIsHidden(state: Bool) {
        self.backButton.isHidden = state
    }
    @IBAction func backButtonAction(_ sender: Any) {
        backButtonHandler?()
    }
}
