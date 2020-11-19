//
//  ChatAPI.swift
//  Pharmacy Manager
//
//  Created by Mikhail Timoscenko on 19.11.2020.
//  Copyright © 2020 PharmacyManager. All rights reserved.
//

import Foundation
import Moya

enum ChatAPI {

    case lastChats
    case lastProducts
}

extension ChatAPI: RequestConvertible {

    var path: String {
        switch self {
        case .lastChats:
            return "user/chat/last-opened-chats"
        case .lastProducts:
            return "user/chat/last-global-products"
        }
    }

    var method: Moya.Method {
        switch self {
        case .lastChats:
            return .get
        case .lastProducts:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .lastChats:
            return .requestParameters(parameters: ["page": 1, "per_page": 4], encoding: URLEncoding.default)
        case .lastProducts:
            return .requestPlain
        }
    }

}
