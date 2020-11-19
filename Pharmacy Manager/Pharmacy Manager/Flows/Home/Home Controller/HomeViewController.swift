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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    @IBAction func searchTapped(_ sender: Any) {
        model.openSearch()
    }

    @IBAction func scannerTapped(_ sender: Any) {

    }
}

extension HomeViewController: HomeViewControllerInput {

    func networkingDidComplete(errorText: String?) {

    }

}
