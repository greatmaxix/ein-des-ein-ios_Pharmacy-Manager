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

    }

}

extension ProfileFlowCoordinator {

}
