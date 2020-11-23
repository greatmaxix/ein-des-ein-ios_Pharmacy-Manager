//
//  ProfileFlowCoordinator.swift
//  Pharmacy Manager
//
//  Created by Mikhail Timoscenko on 10.09.2020.
//  Copyright © 2020 PharmacyManager. All rights reserved.
//

import Foundation
import EventsTree

class ProfileFlowCoordinator: EventNode, TabBarEmbedCoordinable {

    let tabItemInfo = TabBarItemInfo(
        title: L10n.Tabbar.profile,
        icon: Asset.TabBar.tabbarProfile.image.withRenderingMode(.alwaysOriginal),
        highlightedIcon: Asset.TabBar.tabbarProfile.image.withRenderingMode(.alwaysOriginal)
    )

    private var navigationController: UINavigationController!
    
    func createFlow() -> UIViewController {
        let root = StoryboardScene.Profile.profileViewController.instantiate()
        let model = ProfileModel(parent: self)
        root.model = model
        model.output = root

        navigationController = UINavigationController(rootViewController: root)

        return navigationController
    }

    override init(parent: EventNode?) {
        super.init(parent: parent)
        
        addHandler(.onRaise) { [weak self] (event: ProfileEvent) in
            guard let self = self else { return }
            
            switch event {
            case .presentAboutAppViewController:
                self.presentAboutAppViewController()
            case .pushNotificationViewController:
                self.presentNotificationViewController()
            case .presentNeedHelpViewController:
                self.presentNeedHelpViewController()
            default:
                break
            }
        }
    }
}

private extension ProfileFlowCoordinator {
    
    func presentAboutAppViewController() {
        let viewController = StoryboardScene.AboutAppViewController.aboutAppViewController.instantiate()
        let model = AboutAppModel(parent: self)
        viewController.model = model
        model.output = viewController
        
        navigationController.pushViewController(viewController, animated: true)
    }

    func presentNotificationViewController() {
        let viewController = StoryboardScene.NotificationViewController.notificationViewController.instantiate()
        
        let model = NotificationModel(parent: self)
        viewController.model = model
        model.output = viewController
        
        navigationController.pushViewController(viewController, animated: true)
    }

    func presentNeedHelpViewController() {
        let viewController = StoryboardScene.NeedHelpViewController.needHelpViewController.instantiate()
        let model = NeedHelpModel(parent: self)
        viewController.model = model
        model.output = viewController
        
        navigationController.pushViewController(viewController, animated: true)
    }
}
