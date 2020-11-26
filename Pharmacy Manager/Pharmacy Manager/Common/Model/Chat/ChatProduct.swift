//
//  ProductModel.swift
//  Pharmacy
//
//  Created by Egor Bozko on 16.11.2020.
//  Copyright © 2020 pharmacy. All rights reserved.
//

import Foundation

struct ChatProduct: Decodable, Equatable {
    
    struct ChatImage: Decodable, Equatable {
        let url: URL
    }
    
    let id: Int
    let name: String
    let releaseForm: String
    let pictures: [ChatImage]
    let priceRange: PriceRange?
    var liked: Bool = false
    
    var title: String {
        return name.htmlToString
    }
    var releaseFormFormatted: String {
        releaseForm.htmlToString
    }
    
    var asMedicine: Medicine {
        return Medicine(title: name, minPrice: priceRange?.minPrice ?? 0.0, maxPrice: priceRange?.maxPrice ?? 0.0, imageURL: pictures.first?.url.absoluteString, releaseForm: releaseForm, liked: liked, productId: id)
    }
    
    var currency = "₸"
    var minPrice: String {
        return  priceRange?.minPrice.moneyString(with: currency) ?? "--"
    }
    var maxPrice: String {
        return  priceRange?.minPrice.moneyString(with: currency) ?? "--"
    }
    
    static func == (lhs: ChatProduct, rhs: ChatProduct) -> Bool {
        return lhs.id == rhs.id
    }
    
    enum Key: CodingKey {
        case globalProductId
        case rusName
        case releaseForm
        case pictures
        case pharmacyProductsAggregationData
        case liked
    }
    
    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: Key.self)
        id = try c.decode(Int.self, forKey: .globalProductId)
        name = try c.decode(String.self, forKey: .rusName)
        releaseForm = try c.decode(String.self, forKey: .releaseForm)
        pictures = try c.decode([ChatImage].self, forKey: .pictures)
        priceRange = try? c.decode(PriceRange.self, forKey: .pharmacyProductsAggregationData)
        if let isLiked = try? c.decode(Bool.self, forKey: .liked) {
            liked = isLiked
        }
    }
    
    mutating func updateLike(value: Bool) {
        self.liked = value
    }
}
