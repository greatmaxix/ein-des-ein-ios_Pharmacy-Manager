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
    
    private var chatService: ChatService!
    private weak var homeFlow: HomeFlowCoordinator?
    
    init(window: UIWindow) {
        self.window = window

        super.init(parent: nil)
        
        setupDefaultAppearance()
        
        addHandler { [weak self] (event: SignInEvent) in
            guard let `self` = self else { return }

            switch event {
            case .userSignedIn:
                self.presentMainFlow()
            }
        }
        
        addHandler { [weak self] (event: ProfileEvent) in
            guard let `self` = self else { return }

            switch event {
            case .logout:
                self.presentAuthFlow()
            default:
                break
            }
        }
    }
    
    func setupDefaultAppearance() {
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self] ).tintColor = .white
    }

    func startFlow() {
        switch UserSession.shared.authorizationStatus {
        case .authorized:
            presentMainFlow()
        case .notAuthorized:
            presentAuthFlow()
        }
    }

}

// MARK: Navigation

extension AppNavigation {

    fileprivate func presentMainFlow() {
        let coordinator = TabBarCoordinator(parent: self)
        presentCoordinatorFlow(coordinator)
        coordinator.addTabCoordinators(coordinators: tabBarRootCoordinators(for: coordinator))
        if let t = UserSession.shared.user?.topicName {
            chatService = ChatService(topicName: t, delegate: self)
        }
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
        self.homeFlow = homeFlow

        return [homeFlow, catalogFlow, chatFlow, profileFlow]
    }

    private func presentCoordinatorFlow(_ coordinator: Coordinator) {
        let root = coordinator.createFlow()
        window.rootViewController = root
        window.makeKeyAndVisible()
    }

}
extension AppNavigation: ChatServiceDelegate {
    func didRecive(data: ChatMessagesResponse) {
        raise(event: ChatServiceEvent.didRecive(message: data))
        self.homeFlow?.raise(event: HomeEvent.updateData)
    }
}
