//
//  WelcomeFlowCoordinator.swift
//  Pharmacy Manager
//
//  Created by Mikhail Timoscenko on 10.09.2020.
//  Copyright © 2020 PharmacyManager. All rights reserved.
//

import Foundation
import EventsTree

class WelcomeFlowCoordinator: EventNode, TabBarEmbedCoordinable {

    let tabItemInfo = TabBarItemInfo(
        title: L10n.Tabbar.home,
        icon: Asset.TabBar.tabbarHome.image,
        highlightedIcon: Asset.TabBar.tabbarHome.image
    )

    private var navigationController: UINavigationController!

    func createFlow() -> UIViewController {
        let root = StoryboardScene.Auth.signInViewController.instantiate()
        let model = SignInModel(parent: self)
        root.model = model
        model.output = root
        navigationController = UINavigationController(rootViewController: root)

        navigationController.setNavigationBarHidden(true, animated: false)

        return navigationController
    }

    override init(parent: EventNode?) {
        super.init(parent: parent)

    }

}

extension WelcomeFlowCoordinator {

}
