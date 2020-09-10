//
//  AuthCoordinator.swift
//  KyivPost
//
//  Created by Mikhail Timoscenko on 25.06.2020.
//  Copyright © 2020 KyivPost. All rights reserved.
//

import Foundation
import EventsTree

class AuthFlowCoordinator: EventNode, Coordinator {

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

extension AuthFlowCoordinator {

}
