//
//  NetworkTarget.swift
//  KyivPost
//
//  Created by Anton Bal’ on 15.07.2020.
//  Copyright © 2020 KyivPost. All rights reserved.
//

import Foundation
import Moya

public protocol NetworkTarget {
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String { get }
    
    /// The HTTP method used in the request.
    var method: Moya.Method { get }
    
    /// The type of HTTP task to be performed.
    var task: Task { get }
    
    /// Provides stub data for use in testing.
    var sampleData: Data { get }
    
    /// The headers to be used in the request.
    var headers: [String : String]? { get }
}

extension NetworkTarget {
    var sampleData: Data { Data() }
    
    var headers: [String: String]? {
        let data = ["Content-type": "application/json; charset=utf-8"]

        return data
    }
}
