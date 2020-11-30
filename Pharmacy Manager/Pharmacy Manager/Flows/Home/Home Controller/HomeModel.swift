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
    case openScan
    case openProductDetail(product: Medicine)
    case open(chat: Chat?)
}

protocol HomeModelInput: class {
    var chatCount: String { get }
    var messageCount: Int { get }
    func open(chat: Chat?)
    func avatarImages() -> [URL?]
    func messages() -> [Chat]
    var recommendedProducts: [LastProducts] {get}
    func openSearch()
    func loadData()
    func openScan()
    func openProductDetail(productIndex: Int)
}

protocol HomeModelOutput: class {
    func networkingDidComplete(errorText: String?)
    func recommendedProductsWasLoaded(errorText: String?)
}

class HomeModel: Model {

    weak var output: HomeModelOutput!

    private var chats: [Chat] = []
    private var total: Int = 0
    
    private var products: [LastProducts] = []

    private let lastChatAPI = DataManager<ChatAPI, LastChatsResponse>()
    private let lastProductsAPI = DataManager<ChatAPI, LastProductsRecommendResponse>()
//    private let wishListProvider = DataManager<WishListAPI, PostResponse>()

}

extension HomeModel: HomeModelInput, HomeViewControllerOutput {
    func open(chat: Chat?) {
        raise(event: HomeEvent.open(chat: chat))
    }
    
    func openProductDetail(productIndex: Int) {
        let item = products[productIndex]
        let medicine = Medicine(product: item)
        raise(event: HomeEvent.openProductDetail(product: medicine))
    }
    
    var recommendedProducts: [LastProducts] {
        get {
            return products
        }
    }
    
    func openScan() {
        raise(event: HomeEvent.openScan)
    }
    
    var chatCount: String {
        return "\(total)"
    }

    var messageCount: Int {
        return chats.count
    }

    func messages() -> [Chat] {
        var messages: [Chat] = []

        if chats.count >= 1 {
            messages.append(chats[0])
        }

        if chats.count >= 2 {
            messages.append(chats[1])
        }

        return messages
    }

    func avatarImages() -> [URL?] {
        var urls: [URL?] = []
        for chat in chats {
            if let url = chat.customer.avatar?.first?.value {
                urls.append(url)
            } else {
                urls.append(nil)
            }
        }

        return urls
    }

    func openSearch() {
        raise(event: HomeEvent.openSearch)
    }

    func loadData() {

        loadChats()
        loadLastProducts()
    }
    
    private func loadLastProducts() {
        lastProductsAPI.load(target: .lastProducts) {[weak self] result in
            guard let `self` = self else { return }
            
            switch result {
            case .success(let response):
                
                if response.items.count > 2 {
                    let array = Array(response.items.suffix(2))
                    self.products = array
                } else {
                    self.products = response.items.reversed()
                }
                
                self.output.recommendedProductsWasLoaded(errorText: nil)
                
            case .failure(let error):
                self.output.recommendedProductsWasLoaded(errorText: error.localizedDescription)
            }
        }
    }

    private func loadChats() {
        lastChatAPI.load(target: .lastOpened) { [weak self] result in

            guard let `self` = self else {
                return
            }
            switch result {
            case .success(let response):
                self.total = response.totalCount
                self.chats = response.items
                self.output.networkingDidComplete(errorText: nil)
            case .failure(let error):
                self.output.networkingDidComplete(errorText: error.localizedDescription)
            }
        }
    }
}
