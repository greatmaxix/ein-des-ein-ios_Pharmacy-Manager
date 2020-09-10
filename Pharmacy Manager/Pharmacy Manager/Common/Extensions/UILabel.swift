//
//  UILabel.swift
//  KyivPost
//
//  Created by Mikhail Timoscenko on 24.07.2020.
//  Copyright © 2020 KyivPost. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {

    func calculateMaxLines() -> Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(Float.infinity))
        let charSize = font.lineHeight
        let text = (self.text ?? "") as NSString
        let textSize = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font as Any], context: nil)
        let linesRoundedUp = Int(ceil(textSize.height/charSize))
        return linesRoundedUp
    }
}
