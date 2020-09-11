//
//  ProfileViewController.swift
//  Pharmacy Manager
//
//  Created by Mikhail Timoscenko on 11.09.2020.
//  Copyright © 2020 PharmacyManager. All rights reserved.
//

import UIKit

protocol ProfileViewControllerInput: ProfileModelOutput {}
protocol ProfileViewControllerOutput: ProfileModelInput {}

class ProfileViewController: UIViewController {

    var model: ProfileViewControllerOutput!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension ProfileViewController: ProfileViewControllerInput {

    func networkingDidComplete(errorText: String?) {

    }

}
