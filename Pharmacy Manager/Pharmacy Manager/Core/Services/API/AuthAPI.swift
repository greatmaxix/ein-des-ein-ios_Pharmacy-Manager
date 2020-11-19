//
//  APIAuthLayer.swift
//  KyivPost
//
//  Created by Mikhail Timoscenko on 22.06.2020.
//  Copyright © 2020 KyivPost. All rights reserved.
//

import Foundation
import Moya

enum AuthAPI {
    // swiftlint:disable all

    case signIn(email: String, password: String)
}

extension AuthAPI: RequestConvertible {

    var authorizationType: AuthorizationType? {
        return .bearer
    }

    var path: String {
        switch self {
        case .signIn:
            return "user/pharmacist/login"
        }
    }

    var method: Moya.Method {
        switch self {
        case .signIn:
            return .post
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .signIn(let email, let password):
            return .requestParameters(parameters: [
                "email" : email,
                "password" : password], encoding: JSONEncoding.default)
        }
    }
}
