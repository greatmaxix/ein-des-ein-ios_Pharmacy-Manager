//
//  Product.swift
//  Pharmacy
//
//  Created by Anton Bal’ on 13.08.2020.
//  Copyright © 2020 pharmacy. All rights reserved.
//

import Foundation
import Moya

struct Product: Decodable, Equatable {
    
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    // MARK: - Properties
    let identifier: Int
    let name: String
    let releaseForm: String
    let description: String
    let category: String
    var imageURLs: [URL]
    let activeSubstances: [String]
    let categoryCode: String
    let manufacturer: Manufacturer
    let isLiked: Bool
    
    var currency = "₸"
    var minPrice: String {
        return  priceRange?.minPrice.moneyString(with: currency) ?? "--"
    }
    var maxPrice: String {
        return  priceRange?.minPrice.moneyString(with: currency) ?? "--"
    }
    
    private let priceRange: PriceRange?

    // MARK: - Init / Deinit methods
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        
        identifier = try container.decode(Int.self, forKey: .globalProductId)
        name = try container.decode(String.self, forKey: .rusName)
        releaseForm = try container.decode(String.self, forKey: .releaseForm)
        description = try container.decode(String.self, forKey: .description)
        category = try container.decode(String.self, forKey: .category)
        categoryCode = try container.decode(String.self, forKey: .categoryAtcCode)

        var picturesUnkeyedContainer = try? container.nestedUnkeyedContainer(forKey: .pictures)
        let urlContainer = try? picturesUnkeyedContainer?.nestedContainer(keyedBy: Keys.self)
        imageURLs = []
        if let pictureUrl = try? urlContainer?.decode(URL.self, forKey: .url) {
            imageURLs = [pictureUrl]
        }
        
        activeSubstances = try container.decode([String].self, forKey: .activeSubstances)
        manufacturer = try container.decode(Manufacturer.self, forKey: .manufacturerData)
        priceRange = try container.decodeIfPresent(PriceRange.self, forKey: .pharmacyProductsAggregationData)
        isLiked = (try? container.decode(Bool.self, forKey: .liked)) ?? false
    }
}

// MARK: - Coding Keys
extension Product {
    
    enum Keys: String, CodingKey {
        case globalProductId
        case rusName
        case releaseForm
        case description
        case category
        case pictures
        case activeSubstances
        case manufacturerData
        case pharmacyProductsAggregationData
        case liked
        case url
        case categoryAtcCode
    }
}
