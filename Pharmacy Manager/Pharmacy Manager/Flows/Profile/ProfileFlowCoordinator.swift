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
        icon: Asset.TabBar.tabbarProfile.image,
        highlightedIcon: Asset.TabBar.tabbarProfile.image
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

        addHandler { [weak self] (event: SignInEvent) in
            guard let `self` = self else { return }

            //            switch event {
            //
            //            }
        }
    }

}

extension ProfileFlowCoordinator {

}
