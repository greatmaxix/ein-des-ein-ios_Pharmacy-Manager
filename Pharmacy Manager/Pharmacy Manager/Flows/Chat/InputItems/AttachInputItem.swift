//
//  AttachInputItem.swift
//  Pharmacy
//
//  Created by Egor Bozko on 06.11.2020.
//  Copyright © 2020 pharmacy. All rights reserved.
//

import UIKit
import InputBarAccessoryView

class AttachInputItem: InputBarButtonItem {
    
    struct GUI {
        static let size = CGSize(width: 30.0, height: 36.0)
        static let imageRect = CGRect(x: 12.0, y: 0.0, width: 26.0, height: 30.0)
    }
    
    override var intrinsicContentSize: CGSize {
        return GUI.size
    }
    
    init(view: InputBarAccessoryView?, action: @escaping InputBarButtonItemAction) {
        super.init(frame: .zero)
        inputBarAccessoryView = view
        imageView?.contentMode = .scaleAspectFit
        setImage(Asset.Images.Chat.attachment.image, for: .normal)
        setImage(Asset.Images.Chat.attachmentHighlighted.image, for: .highlighted)
        onTouchUpInside(action)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
