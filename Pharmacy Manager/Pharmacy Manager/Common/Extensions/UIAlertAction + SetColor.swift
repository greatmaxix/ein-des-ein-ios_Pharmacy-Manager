//
//  UIAlertAction + SetColor.swift
//  Pharmacy Manager
//
//  Created by Sergey berdnik on 23.11.2020.
//  Copyright © 2020 PharmacyManager. All rights reserved.
//

import UIKit

extension UIAlertAction {
    var titleTextColor: UIColor? {
        get {
            return self.value(forKey: "titleTextColor") as? UIColor
        } set {
            self.setValue(newValue, forKey: "titleTextColor")
        }
    }
}
