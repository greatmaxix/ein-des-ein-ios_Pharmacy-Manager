//
//  ProductAPI.swift
//  Pharmacy
//
//  Created by Sapa Denys on 02.10.2020.
//  Copyright © 2020 pharmacy. All rights reserved.
//

import Moya

enum ProductAPI: RequestConvertible {
    
    struct Parameters {
        static let itemPerPage: Int = 20
    }
    
    case global(identifier: Int)
    case userGlobal(_ page: Int)
    case search(_ term: String, page: Int)
    
    var path: String {
        switch self {
        case .global(let identifier):
            return "public/products/global-product/\(identifier)"
        case .userGlobal:
            return "user/global-products"
        case .search:
            return "public/products/search"
        }
    }
    
    var method: Method {
        switch self {
        case .global, .userGlobal, .search:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .global:
            return .requestPlain
        case .userGlobal(let page):
            return .requestParameters(parameters: ["page": page, "per_page": Parameters.itemPerPage], encoding: URLEncoding.queryString)
        case .search(let term, let page):
            return .requestParameters(parameters: ["page": page, "name": term,  "per_page": Parameters.itemPerPage], encoding: URLEncoding.queryString)
        }
    }
}
