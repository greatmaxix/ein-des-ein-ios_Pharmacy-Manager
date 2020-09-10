//
//  StringFormatPrecision.swift
//  KyivPost
//
//  Created by Anton Bal’ on 24.07.2020.
//  Copyright © 2020 KyivPost. All rights reserved.
//

import Foundation

extension Int {
    func precision(f: Int) -> String {
        return String(format: "%.\(f)d", self)
    }
}

extension Double {
    func precision(f: Int) -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = f
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
