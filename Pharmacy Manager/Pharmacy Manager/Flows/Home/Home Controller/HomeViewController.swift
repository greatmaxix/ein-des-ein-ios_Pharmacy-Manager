//
//  HomeViewController.swift
//  Pharmacy Manager
//
//  Created by Mikhail Timoscenko on 11.09.2020.
//  Copyright © 2020 PharmacyManager. All rights reserved.
//

import UIKit

protocol HomeViewControllerInput: HomeModelOutput {}
protocol HomeViewControllerOutput: HomeModelInput {}

class HomeViewController: UIViewController {

    var model: HomeViewControllerOutput!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension HomeViewController: HomeViewControllerInput {

    func networkingDidComplete(errorText: String?) {

    }

}
