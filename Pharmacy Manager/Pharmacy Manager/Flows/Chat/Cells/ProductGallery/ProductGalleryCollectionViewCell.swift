//
//  ProductGalleryCollectionViewCell.swift
//  Pharmacy Manager
//
//  Created by Egor Bozko on 24.11.2020.
//  Copyright © 2020 PharmacyManager. All rights reserved.
//

import UIKit
import Foundation

class ProductGalleryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productContainer: UIView! {
        didSet {
            productContainer.layer.cornerRadius = 10.0
            productContainer.layer.masksToBounds = true
            productContainer.dropBlueShadow()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        productImage.image = nil
    }
    
    func apply(product: ChatProduct) {
        if let url = product.pictures.first?.url {
            productImage.loadImageBy(url: url, placeholder: Asset.Images.Catalogs.medicineImagePlaceholder.image)
        } else {
            productImage.image = Asset.Images.Catalogs.medicineImagePlaceholder.image
        }
        nameLabel.text = product.name.htmlToString
        detailsLabel.text = product.releaseForm.htmlToString
        if let p = product.priceRange?.minPrice {
            priceLabel.text = "\(p)"
        }
    }
}
