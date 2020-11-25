//
//  LastProductsRecommend.swift
//  Pharmacy Manager
//
//  Created by Sergey berdnik on 25.11.2020.
//  Copyright © 2020 PharmacyManager. All rights reserved.
//

import Foundation

struct LastProductsRecommendResponse: Codable {
    
    var items: [LastProducts]
    
    enum Keys: String, CodingKey {
        case items
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)

        items = try container.decode([LastProducts].self, forKey: .items)
    }
}

struct LastProducts: Codable {

    var productId: Int
    let productName: String
    var releaseForm: String
    var minPrice: Decimal?
    var maxPrice: Decimal?
    var pictureUrls: [String]
    
    enum Keys: String, CodingKey {
        case globalProductId
        case pharmacyProductsAggregationData
        case pictures
        case releaseForm
        case rusName
        case url
        
        case minPrice
        case maxPrice
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        productId = try container.decode(Int.self, forKey: .globalProductId)
        productName = try container.decode(String.self, forKey: .rusName)
        releaseForm = try container.decode(String.self, forKey: .releaseForm)
        
        var picturesContainer = try? container.nestedUnkeyedContainer(forKey: .pictures)
        let urlContainer = try? picturesContainer?.nestedContainer(keyedBy: Keys.self)
        pictureUrls = []
        if let pictureUrl = try? urlContainer?.decode(String.self, forKey: .url) {
            pictureUrls = [pictureUrl]
        }
        
        let priceContainer = try? container.nestedContainer(keyedBy: Keys.self, forKey: .pharmacyProductsAggregationData)
        minPrice = try? priceContainer?.decode(Decimal.self, forKey: .minPrice)
        maxPrice = try? priceContainer?.decode(Decimal.self, forKey: .maxPrice)
    }
}
