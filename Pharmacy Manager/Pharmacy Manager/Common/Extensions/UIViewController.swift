//
//  UIViewController.swift
//  KyivPost
//
//  Created by Mikhail Timoscenko on 23.06.2020.
//  Copyright © 2020 KyivPost. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func setupEmptyView(title: String, decriptionText: String, buttonTitle: String, imageName: String, actionHandler: @escaping () -> Void) -> EmptyResultsView {
        
        let emptyView: EmptyResultsView = EmptyResultsView.fromNib()
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emptyView)
        emptyView.constraintsToSuperView()
        
        emptyView.setup(title: title, decriptionText: decriptionText, buttonTitle: buttonTitle)
        
        emptyView.setupImage(image: UIImage(named: imageName)!)
        emptyView.tapButtonHandler = actionHandler
        
        return emptyView
    }
}
