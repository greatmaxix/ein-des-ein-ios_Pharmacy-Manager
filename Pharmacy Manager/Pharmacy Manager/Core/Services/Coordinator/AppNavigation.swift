//
//  AppNavigation.swift
//  KyivPost
//
//  Created by Mikhail Timoscenko on 22.06.2020.
//  Copyright © 2020 KyivPost. All rights reserved.
//

import Foundation
import UIKit
import EventsTree

final class AppNavigation: EventNode {

    fileprivate unowned let window: UIWindow

    init(window: UIWindow) {
        self.window = window

        super.init(parent: nil)
    }

    func startFlow() {
        
    }

}

// MARK: Navigation

extension AppNavigation {

    fileprivate func presentMainFlow() {
        let coordinator = TabBarCoordinator(parent: self)

        presentCoordinatorFlow(coordinator)
        coordinator.addTabCoordinators(coordinators: tabBarRootCoordinators(for: coordinator))
    }

    private func tabBarRootCoordinators(for coordinator: TabBarCoordinator) -> [TabBarEmbedCoordinable] {
        let exploreFlow = ExploreFlowCoordinator(parent: coordinator)
        let savedFlow = SavedFlowCoordinator(parent: coordinator)
        let myPostFlow = MyPostFlowCoordinator(parent: coordinator)
        let notificationFlow = NotificationFlowCoordinator(parent: coordinator)
        let archiveFlow = ArchieveFlowCoordinator(parent: coordinator)

        return [exploreFlow, savedFlow, myPostFlow, notificationFlow, archiveFlow]
    }

    private func presentCoordinatorFlow(_ coordinator: Coordinator) {
        let root = coordinator.createFlow()
        window.rootViewController = root
        window.makeKeyAndVisible()
    }

}
