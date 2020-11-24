//
//  ChatInputBar.swift
//  Pharmacy
//
//  Created by Egor Bozko on 06.11.2020.
//  Copyright © 2020 pharmacy. All rights reserved.
//

import UIKit
import InputBarAccessoryView

protocol ChatInputBarDelegate: InputBarAccessoryViewDelegate {
    func attach()
    func didSelect(action: ImageSelectionAction)
    func openCamera()
}

final class ChatInputBar: InputBarAccessoryView {
    
    var attachInputItem: AttachInputItem!
    var productsInputItem: ProductInputItem!
    
    lazy var chatGallery: ChatGallery = {
        let width = bottomStackView.frame.width
        let itemWidth = width / 3.0
        let rect = CGRect(origin: .zero, size: CGSize(width: width, height: itemWidth * 2))
        let g = ChatGallery(frame: rect)
        setStackViewItems( bottomStackViewItems + [g], forStack: .bottom, animated: false)
        g.actionsDelegate = self
        g.isHidden = true
        return g
    }()
    
    lazy var productsGallery: ProductsGallery = {
        let width = bottomStackView.frame.width
        let itemWidth = width / 3.0
        let rect = CGRect(origin: .zero, size: CGSize(width: width, height: 300.0))
        let g = ProductsGallery(frame: rect)
        setStackViewItems(bottomStackViewItems + [g], forStack: .bottom, animated: false)
        g.isHidden = true
        return g
    }()
    
    struct GUI {
        static let cornerRadius: CGFloat = 24.0
        static let maskedCorners: CACornerMask = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        static let backgroundColor = UIColor.white
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        setupSendButton()
        separatorLine.height = 8.0
        backgroundColor = .clear
        separatorLine.backgroundColor = .clear
        inputTextView.backgroundColor = Asset.LegacyColors.lightGray.color
        inputTextView.layer.cornerRadius = 17
        inputTextView.layer.borderWidth = 1.0
        inputTextView.layer.borderColor = Asset.LegacyColors.mediumGrey.color.cgColor
        
        backgroundView.layer.cornerRadius = GUI.cornerRadius
        backgroundView.layer.maskedCorners = GUI.maskedCorners
        backgroundView.backgroundColor = GUI.backgroundColor
        backgroundView.layer.masksToBounds = true
        
        middleContentViewPadding = UIEdgeInsets(top: 8.0, left: 0.0, bottom: 12.0, right: 0.0)
        
        var textInset = inputTextView.textContainerInset
        textInset.left = 12.0
        textInset.right = 30.0
        inputTextView.textContainerInset = textInset
        inputTextView.placeholderLabel.text = " Что Вас волнует?"
        inputTextView.placeholderLabel.textColor = Asset.LegacyColors.gray.color
        
        setLeftStackViewWidthConstant(to: 90.0, animated: false)
        
        attachInputItem = AttachInputItem(view: self) {[weak self] _ in
            (self?.delegate as? ChatInputBarDelegate)?.attach()
        }
        
        productsInputItem = ProductInputItem(view: self, action: {[weak self] _ in
            self?.showProductGallery()
        })
        middleContentViewPadding.left = 16.0
        setStackViewItems([productsInputItem, attachInputItem], forStack: .left, animated: false)
        
        attachInputItem.setSize(CGSize(width: 26.0, height: 38.0), animated: false)
        
        middleContentViewPadding.right = -62.0
        bottomStackView.axis = .vertical
        dropBlackShadow()
    }
    
    private func setupSendButton() {
        shouldManageSendButtonEnabledState = false
        sendButton = ChatSendButton().configure {
            $0.setSize(CGSize(width: 52, height: 36), animated: false)
            $0.isEnabled = true
            $0.title = ""
            $0.image = Asset.Images.Chat.send.image
            $0.alpha = 0.0
        }.onTouchUpInside {
            $0.inputBarAccessoryView?.didSelectSendButton()
        }
        setRightStackViewWidthConstant(to: 75.0, animated: false)
        setStackViewItems([sendButton, InputBarButtonItem.fixedSpace(2.0)], forStack: .right, animated: false)
        
        sendButton.setSize(CGSize(width: 30.0, height: 38.0), animated: false)
        
        sendButton.onTextViewDidChange {(button, inputView) in
            guard let b = button as? ChatSendButton else { return }
            let isEmpty = inputView.text.isEmpty
            if b.appearanceState != .attachment {
                b.appearanceState = isEmpty ? .hidden : .normal
            }
        }
        sendButton.backgroundColor = .clear
    }
    
    func showGallery() {
        
        DispatchQueue.main.async { [weak self] in
            self?.attachInputItem.isHighlighted = true
            UIView.animate(withDuration: 0.3) {
                self?.chatGallery.isHidden = false
                self?.layoutStackViews([.bottom])
            }
        }
    }
    
    func showProductGallery() {
        let g = productsGallery
        switch g.appearanceState {
        case .closed:
            g.appearanceState = g.appearanceState == .closed ? .opened : .closed
        case .opened:
            g.appearanceState = g.appearanceState == .closed ? .opened : .closed
        default: break
        }
        
        DispatchQueue.main.async {
            self.productsInputItem.isHighlighted = g.appearanceState == .opened
            
            if self.chatGallery.isHidden == false {
                self.hideGallery()
            }
            
            UIView.animate(withDuration: 0.3) {
                self.productsGallery.isHidden = !self.productsInputItem.isHighlighted
                self.layoutStackViews([.bottom])
            }
        }
    }
    
    func hideGallery() {
        if chatGallery.isHidden == false {
            DispatchQueue.main.async { [weak self] in
                self?.attachInputItem.isHighlighted = false
                UIView.animate(withDuration: 0.3) {
                    self?.chatGallery.isHidden = true
                    self?.layoutStackViews([.bottom])
                }
            }
        }
    }
    
    func updateAppearanceWithAttachments(count: Int) {
        guard let b = sendButton as? ChatSendButton else { return }
        if count > 0 {
            b.appearanceState = .attachment
        } else {
            if inputTextView.text.isEmpty {
                b.appearanceState = .hidden
            } else {
                b.appearanceState = .normal
            }
        }
    }
}

extension ChatInputBar: ChatGalleryDelegate {
    func openCamera() {
        (delegate as? ChatInputBarDelegate)?.openCamera()
    }
    
    func imageAction(action: ImageSelectionAction) {
        (delegate as? ChatInputBarDelegate)?.didSelect(action: action)
    }
    
    func needHideGallery() {
        hideGallery()
    }
}

class ChatSendButton: InputBarSendButton {
    
    enum AppearanceState {
        case normal, attachment, hidden
    }
    
    override var isEnabled: Bool {
        get {
            return true
        }
        set {
            print("\(newValue)")
        }
    }
    
    var appearanceState = AppearanceState.hidden {
        didSet {
            switch appearanceState {
            case .normal:
                isEnabled = true
                UIView.animate(withDuration: 0.2) { [weak self] in
                    self?.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
                    self?.alpha = 1.0
                }
            case .attachment:
                isEnabled = true
                UIView.animate(withDuration: 0.2) { [weak self] in
                    let scaleTransfor = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
                    self?.transform = scaleTransfor.concatenating(CGAffineTransform(rotationAngle: CGFloat.pi * -0.5))
                    self?.alpha = 1.0
                }
            case .hidden:
                UIView.animate(withDuration: 0.2) { [weak self] in
                    self?.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
                    self?.alpha = 0.0
                }
            }
        }
    }
    
}
