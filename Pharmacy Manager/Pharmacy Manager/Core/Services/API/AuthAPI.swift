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

    case register(firstname: String, lastname: String, email: String, password: String)
    case reset(email: String)
    case signIn(email: String, password: String)

}

extension AuthAPI: NetworkTarget, AccessTokenAuthorizable {

    var authorizationType: AuthorizationType? {
        return .bearer
    }

    var path: String {
        switch self {
        case .register:
            return "/users/register"
        case .reset:
            return "/users/lostpassword"
        case .signIn:
            return "/users/login"
        }
    }

    var method: Moya.Method {
        switch self {
        case .register:
            return .post
        case .reset:
            return .post
        case .signIn:
            return .post
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .register(let firstname, let lastname, let email, let password):
            return .requestParameters(parameters: [
                "user_email": email,
                "user_firstname": firstname,
                "user_lastname": lastname,
                "user_password": password], encoding: JSONEncoding.default)
        case .reset(let email):
            return .requestParameters(parameters: [
                "user_email" : email], encoding: JSONEncoding.default)
        case .signIn(let email, let password):
            return .requestParameters(parameters: [
                "username" : email,
                "password" : password], encoding: JSONEncoding.default)
        }
    }
}
