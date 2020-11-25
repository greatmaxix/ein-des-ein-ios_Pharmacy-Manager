//
//  ChatFlowCoordinator.swift
//  Pharmacy Manager
//
//  Created by Mikhail Timoscenko on 10.09.2020.
//  Copyright © 2020 PharmacyManager. All rights reserved.
//

import Foundation
import EventsTree

class ChatFlowCoordinator: EventNode, TabBarEmbedCoordinable {
    
    let tabItemInfo = TabBarItemInfo(
        title: L10n.Tabbar.chat,
        icon: Asset.TabBar.tabbarChat.image.withRenderingMode(.alwaysOriginal),
        highlightedIcon: Asset.TabBar.tabbarChat.image.withRenderingMode(.alwaysOriginal)
    )
    
    private var navigationController: UINavigationController!
    
    func createFlow() -> UIViewController {
        let root = StoryboardScene.Chat.chatsViewController.instantiate()
        let model = ChatsListModel(parent: self)
        root.model = model
        model.output = root
        navigationController = NavigationController(rootViewController: root)
        
        return navigationController
    }
    
    override init(parent: EventNode?) {
        super.init(parent: parent)
        addHandler(.onRaise) {[weak self] (event: ChatListEvent) in
            switch event {
            case .open(let chat):
                self?.open(chat)
            default: break
            }
        }
    }
    
    private func open(_ chat: Chat) {
        let vc = ChatCoordinator(parent: self, navigation: navigationController, chat: chat).createFlow()
        navigationController.pushViewController(vc, animated: true)
    }
}

extension ChatFlowCoordinator {
    
}
