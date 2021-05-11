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
    
    @IBOutlet weak var newRequstsTitleLabel: UILabel!
    @IBOutlet weak var inDevelopTitleLabel: UILabel!
    @IBOutlet weak var recentRecommendationTitleLabel: UILabel!

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
    
    @IBOutlet private var recommendedViews: [LastRecommendedView]!

    override func viewDidLoad() {
        super.viewDidLoad()

        containerView.isHidden = true
        
        newRequstsTitleLabel.text = L10n.HomeScreen.newRequestTitle
        inDevelopTitleLabel.text = L10n.HomeScreen.inDevelopment
        recentRecommendationTitleLabel.text = L10n.HomeScreen.recentRecommendation

        upperMessageView.dropLightBlueShadow()
        lowerMessageView.dropLightBlueShadow()
        newChatsView.dropLightBlueShadow()
        inDevView.dropLightBlueShadow()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        recommendedViews.forEach({$0.isHidden = true})
        
        activityIndicator.show(animated: true)
        model.loadData()
    }
    
    @IBAction func searchTapped(_ sender: Any) {
        model.openSearch()
    }

    @IBAction func scannerTapped(_ sender: Any) {
        model.openScan()
    }
    
    @IBAction func openRequests(_ sender: Any) {
        model.open(chat: nil)
    }
    @IBAction func openUpperChat(_ sender: Any) {
        let chat = model.messages()[0]
        model.open(chat: chat)
    }
    
    @IBAction func openLowerChat(_ sender: Any) {
        let chat = model.messages()[1]
        model.open(chat: chat)
    }
    
    private func setupRecommendedProducts() {
        switch model.recommendedProducts.count {
        case 1:
            recommendedViews.first!.setupView(item: model.recommendedProducts[1])
            recommendedViews.first!.isHidden = false
        case 2:
            for index in model.recommendedProducts.indices {
                recommendedViews[index].setupView(item: model.recommendedProducts[index])
                recommendedViews[index].tapActionHandler = {[weak self] in
                    self?.model.openProductDetail(productIndex: index)
                }
            }
            recommendedViews.forEach({$0.isHidden = false})
        default:
            recommendedViews.forEach({$0.isHidden = true})
        }
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
        let messages = model.messages()
        lowerMessageView.isHidden = true
        upperMessageView.isHidden = true
        
        switch messages.count {
        case 1:
            upperMessageView.isHidden = false
            let message = messages[0]
            upperMessageName.text = message.customer.name
            upperMessageText.text = message.lastMessage.messagePreview
            if let url = message.customer.avatar?.first?.value {
                upperMessageAvatar.af.setImage(withURL: url)
            }
        case 0:
            lowerMessageView.isHidden = true
            upperMessageView.isHidden = true
        default:
            upperMessageView.isHidden = false
            let message = messages[0]
            upperMessageName.text = message.customer.name
            upperMessageText.text = message.lastMessage.messagePreview
            if let url = message.customer.avatar?.first?.value {
                upperMessageAvatar.af.setImage(withURL: url)
            }
            
            lowerMessageView.isHidden = false
            let secondMessage = messages[1]
            lowerMessageName.text = secondMessage.customer.name
            lowerMessageText.text = secondMessage.lastMessage.messagePreview
            if let url = secondMessage.customer.avatar?.first?.value {
                lowerMessageAvatar.af.setImage(withURL: url)
            }
        }
    }
}

extension HomeViewController: HomeViewControllerInput {
    func recommendedProductsWasLoaded(errorText: String?) {
        if errorText?.isEmpty ?? true {
            setupRecommendedProducts()
        }
        activityIndicator.hide(animated: true)
    }
    

    func networkingDidComplete(errorText: String?) {
        if errorText?.isEmpty ?? true {
            fillChatInfo()
            fillMessagesInfo()

            containerView.isHidden = false
        }
    }

}
