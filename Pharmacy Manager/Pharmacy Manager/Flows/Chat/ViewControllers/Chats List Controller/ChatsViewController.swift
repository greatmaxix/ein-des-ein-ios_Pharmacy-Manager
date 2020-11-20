//
//  ChatsViewController.swift
//  Pharmacy Manager
//
//  Created by Mikhail Timoscenko on 11.09.2020.
//  Copyright © 2020 PharmacyManager. All rights reserved.
//

import UIKit

protocol ChatsViewControllerInput: ChatsListModelOutput {}
protocol ChatsViewControllerOutput: ChatsListModelInput {}

class ChatsViewController: UIViewController {
    var model: ChatsViewControllerOutput!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension ChatsViewController: ChatsViewControllerInput {

    func networkingDidComplete(errorText: String?) {

    }

}

