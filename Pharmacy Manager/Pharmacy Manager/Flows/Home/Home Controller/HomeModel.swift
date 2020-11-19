//
//  HomeModel.swift
//  Pharmacy Manager
//
//  Created by Mikhail Timoscenko on 11.09.2020.
//  Copyright © 2020 PharmacyManager. All rights reserved.
//

import Foundation
import EventsTree

enum HomeEvent: Event {
    case openSearch
}

protocol HomeModelInput: class {
    func openSearch()
    func loadData()
}

protocol HomeModelOutput: class {
    func networkingDidComplete(errorText: String?)
}

class HomeModel: Model {

    weak var output: HomeModelOutput!

    private var chats: [LastChat] = []

    private let lastChatAPI = DataManager<ChatAPI, LastChatsResponse>()
//    private let wishListProvider = DataManager<WishListAPI, PostResponse>()

}

extension HomeModel: HomeModelInput, HomeViewControllerOutput {

    func openSearch() {
        raise(event: HomeEvent.openSearch)
    }

    func loadData() {
        lastChatAPI.load(target: .lastChats) { [weak self] result in
            guard let `self` = self else {
                return
            }
            switch result {
            case .success(let response):
                self.chats = response.items
                self.output.networkingDidComplete(errorText: nil)
            case .failure(let error):
                self.output.networkingDidComplete(errorText: error.localizedDescription)
            }
        }
    }

}
