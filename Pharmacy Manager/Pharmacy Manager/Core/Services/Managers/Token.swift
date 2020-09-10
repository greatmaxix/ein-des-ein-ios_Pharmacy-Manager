//
//  Token.swift
//  KyivPost
//
//  Created by Mikhail Timoscenko on 22.06.2020.
//  Copyright © 2020 KyivPost. All rights reserved.
//

import Foundation

struct Tokens: Equatable, Codable {
    enum CodingKeys: String, CodingKey {
        case bearer = "access_token"
    }

    let bearer: String?
}
