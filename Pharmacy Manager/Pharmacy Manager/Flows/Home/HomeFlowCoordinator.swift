//
//  HomeFlowCoordinator.swift
//  Pharmacy Manager
//
//  Created by Mikhail Timoscenko on 10.09.2020.
//  Copyright © 2020 PharmacyManager. All rights reserved.
//

import Foundation
import EventsTree

class HomeFlowCoordinator: EventNode, TabBarEmbedCoordinable {

    let tabItemInfo = TabBarItemInfo(
        title: L10n.Tabbar.home,
        icon: Asset.TabBar.tabbarHome.image,
        highlightedIcon: Asset.TabBar.tabbarHome.image
    )

    private var navigationController: UINavigationController!

    func createFlow() -> UIViewController {
        let root = StoryboardScene.Home.homeViewController.instantiate()
        let model = HomeModel(parent: self)
        root.model = model
        model.output = root

        navigationController = UINavigationController(rootViewController: root)
        navigationController.setNavigationBarHidden(true, animated: false)

        return navigationController
    }

    override init(parent: EventNode?) {
        super.init(parent: parent)

        addHandler(.onRaise) { [weak self] (event: HomeEvent) in
            switch event {
            case .openSearch:
                self?.openSearch()
            case .openScan:
                self?.openScan()
                
            }
        }

        addHandler(.onRaise) { [weak self] (event: SearchModelEvent) in
            switch event {
            case .open(let medecine):
                self?.openProductMedicineFor(medicine: medecine)
            default:
                return
            }
        }

    }

}

private extension HomeFlowCoordinator {

     func openScan() {
        let viewController = StoryboardScene.Scan.initialScene.instantiate()
        let model = ScanModel(parent: self)

        viewController.model = model
        model.output = viewController

        navigationController.pushViewController(viewController, animated: true)
    }

    func openSearch() {
        let controller = StoryboardScene.Search.searchViewController.instantiate()
        let model = SearchModel(parent: self)

        controller.model = model
        model.output = controller

        navigationController.pushViewController(controller, animated: true)
    }

    func openProductMedicineFor(medicine: Medicine) {
        let vc = ProductCoordinator(configuration: .init(parent: self, navigation: navigationController)).createFlowFor(product: medicine)
        navigationController.pushViewController(vc, animated: true)
    }
}
