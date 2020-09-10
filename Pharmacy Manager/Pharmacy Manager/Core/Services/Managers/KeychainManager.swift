//
//  KeychainManager.swift
//  KyivPost
//
//  Created by Mikhail Timoscenko on 22.06.2020.
//  Copyright © 2020 KyivPost. All rights reserved.
//

import Foundation

class KeychainManager {

    static let shared = KeychainManager()

    var baseURL: URL {
        // Here we can set different URL's for different Envs
        return URL(string: "google.com")!
    }

    var bearerToken: String {
        return tokens?.bearer ?? String()
    }

    var tokens: Tokens?
}
