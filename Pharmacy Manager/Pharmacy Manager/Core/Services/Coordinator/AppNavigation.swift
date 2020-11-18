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

        addHandler { [weak self] (event: SignInEvent) in
            guard let `self` = self else { return }

            switch event {
            case .userSignedIn:
                self.presentMainFlow()
            }
        }
    }

    func startFlow() {
        presentMainFlow()
    }

}

// MARK: Navigation

extension AppNavigation {

    fileprivate func presentMainFlow() {
        let coordinator = TabBarCoordinator(parent: self)

        presentCoordinatorFlow(coordinator)
        coordinator.addTabCoordinators(coordinators: tabBarRootCoordinators(for: coordinator))
    }

    fileprivate func presentAuthFlow() {
        let coordinator = AuthFlowCoordinator(parent: self)

        presentCoordinatorFlow(coordinator)
    }

    private func tabBarRootCoordinators(for coordinator: TabBarCoordinator) -> [TabBarEmbedCoordinable] {
        let homeFlow = HomeFlowCoordinator(parent: coordinator)
        let catalogFlow = CatalogueCoordinator(parent: coordinator)
        let chatFlow = ChatFlowCoordinator(parent: coordinator)
        let profileFlow = ProfileFlowCoordinator(parent: coordinator)

        return [homeFlow, catalogFlow, chatFlow, profileFlow]
    }

    private func presentCoordinatorFlow(_ coordinator: Coordinator) {
        let root = coordinator.createFlow()
        window.rootViewController = root
        window.makeKeyAndVisible()
    }

}
