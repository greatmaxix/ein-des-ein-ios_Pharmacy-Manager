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
}

protocol ChatsListModelInput: class {

}

protocol ChatsListModelOutput: class {
    func networkingDidComplete(errorText: String?)
}

class ChatsListModel: Model {

    weak var output: ChatsListModelOutput!

}

extension ChatsListModel: ChatsListModelInput, ChatsViewControllerOutput {

}
