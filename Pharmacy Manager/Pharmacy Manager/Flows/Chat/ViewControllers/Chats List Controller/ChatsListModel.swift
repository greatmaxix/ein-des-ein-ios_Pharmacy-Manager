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
    var filteredItems: [Chat] { get }
    func load()
    func didSelect(_ indexPath: IndexPath)
    func searchChat(_ text: String)
}

protocol ChatsListModelOutput: class {
    var isSearchBarEmpty: Bool { get }
    var tableView: UITableView! { get }
    func networkingDidComplete(errorText: String?)
    func didFilterItems()
}

class ChatsListModel: Model {
    var items: [Chat] = []
    var filteredItems: [Chat] = []
    weak var output: ChatsListModelOutput!
    private let chatListProvider = DataManager<ChatAPI, ChatListResponse>()
    func cleanSearch() {
        filteredItems = []
        output.didFilterItems()
    }
    
    override init(parent: EventNode?) {
        super.init(parent: parent)
        addHandler(.onPropagate) {[weak self] (event: ChatServiceEvent) in
            switch event {
            case .didRecive(let message):
                switch message.messageType {
                case .changeStatus:
                    if let c = message.chatBody {
                        self?.proccess(chat: c.item)
                    }
                default: break
                }
            }
        }
    }
    
    private func proccess(chat: Chat) {
        guard let tableView = output.tableView else { return }
        
        tableView.beginUpdates()
        if let index = items.firstIndex(where: {$0 == chat}) {
            items.remove(at: index)
            items.insert(chat, at: index)
            tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        } else {
            items.insert(chat, at: 0)
            tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .top)
        }
        
        tableView.endUpdates()
        
    }
}

extension ChatsListModel: ChatsListModelInput, ChatsViewControllerOutput {
    func searchChat(_ text: String) {
        filteredItems = items.filter({$0.customer.name.range(of: text, options: .caseInsensitive) != nil})
        output.didFilterItems()
    }
    
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
        let item = ((output?.isSearchBarEmpty ?? true) ? items[indexPath.row] : filteredItems[indexPath.row])
        raise(event: ChatListEvent.open(item))
    }
}
