//
//  LocalizedStringConvertible.swift
//  KyivPost
//
//  Created by Anton Bal’ on 23.07.2020.
//  Copyright © 2020 KyivPost. All rights reserved.
//

import Foundation

protocol LocalizedStringConvertible: CustomStringConvertible {
    var localizedDescription: String { get }
}

extension LocalizedStringConvertible {
    var description: String { localizedDescription }
}
