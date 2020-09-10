//
//  UIBarButtonItem.swift
//  KyivPost
//
//  Created by Mikhail Timoscenko on 29.07.2020.
//  Copyright © 2020 KyivPost. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem {

    static func emptyButton() -> UIBarButtonItem {
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        return backBarButtonItem
    }

}
