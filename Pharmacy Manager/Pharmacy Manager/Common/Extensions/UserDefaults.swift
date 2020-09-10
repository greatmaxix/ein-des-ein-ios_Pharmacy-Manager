//
//  UserDefaults.swift
//  KyivPost
//
//  Created by Mikhail Timoscenko on 01.07.2020.
//  Copyright © 2020 KyivPost. All rights reserved.
//

import Foundation

protocol KeyValueStorage {

    func set(_ value: Any?, forKey key: String)
    func object(forKey key: String) -> Any?
    func saveChanges()

}

extension UserDefaults: KeyValueStorage {

    func saveChanges() {
        synchronize()
    }

}
