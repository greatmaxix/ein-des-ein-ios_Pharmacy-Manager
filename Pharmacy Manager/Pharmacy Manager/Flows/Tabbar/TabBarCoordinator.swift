//
//  MainFlowCoordinator.swift
//  KyivPost
//
//  Created by Mikhail Timoscenko on 22.06.2020.
//  Copyright © 2020 KyivPost. All rights reserved.
//

import UIKit
import EventsTree

class TabBarCoordinator: EventNode, Coordinator {
    
    private weak var root: TabBarController!

    func createFlow() -> UIViewController {
        let tabBarController = StoryboardScene.Tabbar.tabBarController.instantiate()
        let model = TabBarModel(parent: self)
        tabBarController.model = model
        model.output = tabBarController

        root = tabBarController

        return tabBarController
    }

    func addTabCoordinators(coordinators: [TabBarEmbedCoordinable]) {
        var controllers = [UIViewController]()
        var tabItemMap = [(controller: UIViewController, tabItem: UITabBarItem)]()
        for coordinator in coordinators {
            let controller = coordinator.createFlow()
            let tabItem = coordinator.tabItem()
            tabItemMap.append((controller: controller, tabItem: tabItem))
            controllers.append(controller)
        }

        root.configureTabs(with: tabItemMap)
    }

    fileprivate func presentAuthFlow() {
        let coordinator = AuthFlowCoordinator(parent: self)
        let controller = coordinator.createFlow()

        root.present(controller, animated: true, completion: nil)
    }
    
}
