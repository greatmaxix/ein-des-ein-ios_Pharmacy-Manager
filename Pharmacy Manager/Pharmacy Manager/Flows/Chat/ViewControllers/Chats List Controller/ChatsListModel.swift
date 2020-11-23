//
//  ChatsListModel.swift
//  Pharmacy Manager
//
//  Created by Mikhail Timoscenko on 11.09.2020.
//  Copyright © 2020 PharmacyManager. All rights reserved.
//

import Foundation
import EventsTree

enum ChatListEvent: Event {
    case userSignedIn
    case open(_ chat: Chat)
}

protocol ChatsListModelInput: class {
    var items: [Chat] { get }
    func load()
    func didSelect(_ indexPath: IndexPath)
}

protocol ChatsListModelOutput: class {
    func networkingDidComplete(errorText: String?)
}

class ChatsListModel: Model {
    var items: [Chat] = []
    weak var output: ChatsListModelOutput!
    private let chatListProvider = DataManager<ChatAPI, ChatListResponse>()
}

extension ChatsListModel: ChatsListModelInput, ChatsViewControllerOutput {
    func load() {
        chatListProvider.load(target: .chatList) {[weak self] result in
            switch result {
            case .success(let response):
                self?.items = response.items
                self?.output.networkingDidComplete(errorText: nil)
            case .failure(let error):
                self?.output.networkingDidComplete(errorText: error.localizedDescription)
            }
        }
    }
    
    func didSelect(_ indexPath: IndexPath) {
        raise(event: ChatListEvent.open(items[indexPath.row]))
    }
}
