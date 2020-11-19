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

    @IBOutlet weak var upperMessageView: UIView!
    @IBOutlet weak var lowerMessageView: UIView!
    @IBOutlet weak var upperMessageName: UILabel!
    @IBOutlet weak var upperMessageText: UILabel!
    @IBOutlet weak var lowerMessageName: UILabel!
    @IBOutlet weak var lowerMessageText: UILabel!
    @IBOutlet weak var upperMessageAvatar: UIImageView!
    @IBOutlet weak var lowerMessageAvatar: UIImageView!
    @IBOutlet weak var newChatsView: UIView!
    @IBOutlet weak var inDevView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        containerView.isHidden = true

        upperMessageView.dropLightBlueShadow()
        lowerMessageView.dropLightBlueShadow()
        newChatsView.dropLightBlueShadow()
        inDevView.dropLightBlueShadow()
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

    private func fillMessagesInfo() {
        if model.messageCount == 1 {
            lowerMessageView.isHidden = true
        }

        if model.messageCount == 0 {
            upperMessageView.isHidden = true
            return
        }

        let messages = model.messages()

        if messages.count == 0 {
            return
        } else if let message = messages.first {

            upperMessageName.text = message.customerName
            upperMessageText.text = message.message
            if let url = URL(string: message.customerAvatar ?? "") {
                upperMessageAvatar.af.setImage(withURL: url)
            }
        }

        if messages.count == 1 {
            return
        } else if let message = messages.last {

            lowerMessageName.text = message.customerName
            lowerMessageText.text = message.message
            if let url = URL(string: message.customerAvatar ?? "") {
                lowerMessageAvatar.af.setImage(withURL: url)
            }
        }
    }
}

extension HomeViewController: HomeViewControllerInput {

    func networkingDidComplete(errorText: String?) {
        activityIndicator.hide(animated: true)

        if errorText?.isEmpty ?? true {
            fillChatInfo()
            fillMessagesInfo()

            containerView.isHidden = false
        }
    }

}
