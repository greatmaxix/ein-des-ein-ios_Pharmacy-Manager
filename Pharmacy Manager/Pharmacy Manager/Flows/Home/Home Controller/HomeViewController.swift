//
//  HomeViewController.swift
//  Pharmacy Manager
//
//  Created by Mikhail Timoscenko on 11.09.2020.
//  Copyright © 2020 PharmacyManager. All rights reserved.
//

import UIKit
import MBProgressHUD
import AlamofireImage

protocol HomeViewControllerInput: HomeModelOutput {}
protocol HomeViewControllerOutput: HomeModelInput {}

class HomeViewController: UIViewController {

    var model: HomeViewControllerOutput!

    @IBOutlet weak var containerView: UIView!

    private lazy var activityIndicator: MBProgressHUD = {
        let hud = MBProgressHUD(view: view)
        hud.backgroundView.style = .solidColor
        hud.backgroundView.color = UIColor.black.withAlphaComponent(0.2)
        hud.removeFromSuperViewOnHide = false
        view.addSubview(hud)

        return hud
    }()

    @IBOutlet weak var totalChatsLabel: UILabel!

    @IBOutlet weak var firstAvatarView: UIView!
    @IBOutlet weak var secondAvatarView: UIView!
    @IBOutlet weak var thirdAvatarView: UIView!
    @IBOutlet weak var fourthAvatarView: UIView!

    @IBOutlet weak var fourthImageView: UIImageView!
    @IBOutlet weak var thirdImageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!
    @IBOutlet weak var firstImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        containerView.isHidden = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: false)

        activityIndicator.show(animated: true)
        model.loadData()
    }

    @IBAction func searchTapped(_ sender: Any) {
        model.openSearch()
    }

    @IBAction func scannerTapped(_ sender: Any) {

    }

    private func fillChatInfo() {
        totalChatsLabel.text = model.chatCount

        let urls = model.avatarImages()

        switch urls.count {
        case 4:
            if let url = urls[0] {
                firstImageView.af.setImage(withURL: url)
            }
            if let url = urls[1] {
                secondImageView.af.setImage(withURL: url)
            }
            if let url = urls[2] {
                thirdImageView.af.setImage(withURL: url)
            }
            if let url = urls[3] {
                fourthImageView.af.setImage(withURL: url)
            }
        case 3:
            fourthAvatarView.isHidden = true

            if let url = urls[0] {
                firstImageView.af.setImage(withURL: url)
            }
            if let url = urls[1] {
                secondImageView.af.setImage(withURL: url)
            }
            if let url = urls[2] {
                thirdImageView.af.setImage(withURL: url)
            }
        case 2:
            thirdAvatarView.isHidden = true
            fourthAvatarView.isHidden = true

            if let url = urls[0] {
                firstImageView.af.setImage(withURL: url)
            }
            if let url = urls[1] {
                secondImageView.af.setImage(withURL: url)
            }
        case 1:
            thirdAvatarView.isHidden = true
            fourthAvatarView.isHidden = true
            secondAvatarView.isHidden = true

            if let url = urls[0] {
                firstImageView.af.setImage(withURL: url)
            }
        case 0:
            thirdAvatarView.isHidden = true
            fourthAvatarView.isHidden = true
            secondAvatarView.isHidden = true
            firstAvatarView.isHidden = true
        default:
            return
        }
    }
}

extension HomeViewController: HomeViewControllerInput {

    func networkingDidComplete(errorText: String?) {
        activityIndicator.hide(animated: true)

        if errorText?.isEmpty ?? true {
            fillChatInfo()

            containerView.isHidden = false
        }
    }

}
