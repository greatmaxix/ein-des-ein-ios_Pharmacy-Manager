//
//  TabBarModel.swift
//  KyivPost
//
//  Created by Mikhail Timoscenko on 22.06.2020.
//  Copyright © 2020 KyivPost. All rights reserved.
//

import EventsTree

enum Tab: Int {
    case feed = 0
    case catalog
    case chats
    case settings
}

enum TabBarEvent: Event {

    case userWantsToChangeTab(newTab: Tab)

}

protocol TabBarModelInput: ControllerVisibilityOutput {}

protocol TabBarModelOutput: class {
    func changeCurrentTab(_ tab: Tab)
}

class TabBarModel: Model {

    weak var output: TabBarModelOutput!

    override init(parent: EventNode?) {
        super.init(parent: parent)

        addHandler { [weak self] (event: TabBarEvent) in
            if case .userWantsToChangeTab(let tab) = event {
                self?.output.changeCurrentTab(tab)
            }
        }
    }

}

extension TabBarModel: TabBarModelInput, TabBarControllerOutput {}
