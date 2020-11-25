//
//  ChatTableViewCell.swift
//  Pharmacy Manager
//
//  Created by Egor Bozko on 20.11.2020.
//  Copyright © 2020 PharmacyManager. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    @IBOutlet weak var content: UIView! {
        didSet {
            content.layer.cornerRadius = 12.0
            content.dropLightBlueShadow()
        }
    }
    @IBOutlet weak var avatarImageView: UIImageView! {
        didSet {
            avatarImageView.layer.borderWidth = 1.0
            avatarImageView.layer.cornerRadius = 24.0
            avatarImageView.dropBlackShadow()
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var chatId: Int = 0

    func apply(chat: Chat) {
        chatId = chat.id
        nameLabel.text = chat.customer.name
        messageLabel.text = chat.lastMessage.messagePreview
        timeLabel.text = chat.lastMessage.createdAt.date()?.timeString
        if let url = chat.user.avatar?.first?.value {
            avatarImageView.loadImageBy(url: url)
        }
        switch chat.status {
        case .closed:
            avatarImageView.layer.borderColor = Asset.LegacyColors.textDarkGray.color.cgColor
        default:
            avatarImageView.layer.borderColor = Asset.LegacyColors.welcomeGreen.color.cgColor
        }
    }
    
}
