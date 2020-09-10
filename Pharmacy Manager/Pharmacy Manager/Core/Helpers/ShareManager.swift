//
//  ShareManager.swift
//  KyivPost
//
//  Created by Mikhail Timoscenko on 11.08.2020.
//  Copyright © 2020 KyivPost. All rights reserved.
//

import Foundation
import UIKit

class ShareManager {

    static let shared = ShareManager()

    func share(title: String?, image: UIImage?, url: URL?, in controller: UIViewController) {

        let activityController = UIActivityViewController(activityItems: [title, image, url], applicationActivities: nil)

        controller.present(activityController, animated: true, completion: nil)
    }

}
