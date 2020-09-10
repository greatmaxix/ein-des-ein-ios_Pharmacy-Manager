//
//  UITableView.swift
//  KyivPost
//
//  Created by Anton Bal’ on 16.07.2020.
//  Copyright © 2020 KyivPost. All rights reserved.
//

import UIKit

extension UITableView {
    func updateWitoutAnimation(_ updates: @autoclosure () -> Void?) {
        UIView.setAnimationsEnabled(false)
        beginUpdates()
        updates()
        endUpdates()
        UIView.setAnimationsEnabled(true)
    }
}
