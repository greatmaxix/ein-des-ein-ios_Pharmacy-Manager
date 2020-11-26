//
//  ChatProductCollectionViewCell.swift
//  Pharmacy
//
//  Created by Egor Bozko on 09.11.2020.
//  Copyright © 2020 pharmacy. All rights reserved.
//

import UIKit
import MessageKit
enum ChatProductAction {
    case likeToggle, openProduct
}

typealias ChatProductHandler = (ChatProductAction) -> Void

class ChatProductCollectionViewCell: MessageCollectionViewCell {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var productContainer: UIView! {
        didSet {
            productContainer.layer.cornerRadius = 10.0
            productContainer.layer.masksToBounds = true
            productContainer.dropBlackShadow()
        }
    }
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint! {
        didSet {
            trailingConstraint.priority = .defaultLow
        }
    }
    
    var actionHandler: ChatProductHandler?
    
    func apply(product: ChatProduct, actionHandler: @escaping ChatProductHandler, isFromCurrentSender: Bool) {
        if let url = product.pictures.first?.url, url.absoluteString.isEmpty == false {
            productImage.loadImageBy(url: url, placeholder: Asset.Images.Catalogs.medicineImagePlaceholder.image) {[weak self] result in
                switch result {
                case .success(let r):
                    self?.productImage.image = r.image
                default: break
                }
            }
        } else {
            productImage.image = Asset.Images.Catalogs.medicineImagePlaceholder.image
        }
        nameLabel.text = product.name.htmlToString
        detailsLabel.text = product.releaseForm.htmlToString
        priceLabel.text = product.minPrice
        likeButton.isSelected = product.liked
        
        self.actionHandler = actionHandler
        
        if isFromCurrentSender {
            leadingConstraint.priority = .defaultLow
            trailingConstraint.priority = .required
        } else {
            trailingConstraint.priority = .defaultLow
            leadingConstraint.priority = .required
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    override func handleTapGesture(_ gesture: UIGestureRecognizer) {
        actionHandler?(.openProduct)
    }
    
    @IBAction func toggleButton(_ sender: Any) {
        likeButton.isSelected = !likeButton.isSelected
        actionHandler?(.likeToggle)
    }
}
