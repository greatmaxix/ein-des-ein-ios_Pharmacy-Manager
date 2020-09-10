//
//  ErrorPresenter.swift
//  KyivPost
//
//  Created by Mikhail Timoscenko on 03.07.2020.
//  Copyright © 2020 KyivPost. All rights reserved.
//

import Foundation
import UIKit

protocol ErrorPresenter {
    func showError(text: String)
}

extension UIViewController: ErrorPresenter {

    func showError(text: String) {
        let alert = UIAlertController(title: "", message: text, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }

}
