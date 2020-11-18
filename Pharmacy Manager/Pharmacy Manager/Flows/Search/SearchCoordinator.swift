//
//  SearchCoordinator.swift
//  Pharmacy
//
//  Created by Anton Bal’ on 07.08.2020.
//  Copyright © 2020 pharmacy. All rights reserved.
//

import Foundation
import EventsTree

struct SearchFlowConfiguration {
    let parent: EventNode
}

final class SearchCoordinator: EventNode, Coordinator {
    
    private var root: UINavigationController!
    
    func createFlow() -> UIViewController {

        let viewController = StoryboardScene.Product.searchViewController.instantiate()
        let model = SearchModel(parent: self)
        viewController.model = model
        model.output = viewController
        root = NavigationController(rootViewController: viewController)
        
        return root
    }
    
    init(configuration: SearchFlowConfiguration) {
        super.init(parent: configuration.parent)
    
        addHandler { [weak self] (event: SearchModelEvent) in
            switch event {
            case .openList:
                self?.openMedicineList()
            case .open(let medicine):
                self?.open(medicine)
            case .openScan:
                self?.openScan()
            }
        }
    }
}

// MARK: - TabBarEmbedCoordinable

private extension SearchCoordinator {
    
    func openScan() {
        let viewController = StoryboardScene.Scan.initialScene.instantiate()
        let model = ScanModel(parent: self)
        root.hidesBottomBarWhenPushed = true
        viewController.model = model
        model.output = viewController
        root.pushViewController(viewController, animated: true)
    }
    
    func openMedicineList() {
        let viewController = StoryboardScene.Catalogue.medicineListViewController.instantiate()
        let model = MedicineListModel(parent: self)
        viewController.model = model
        model.output = viewController
        root.pushViewController(viewController, animated: true)
    }
    
    func open(_ medicine: Medicine) {
        let viewController = ProductCoordinator(configuration: ProductFlowConfiguration(parent: self, navigation: root)).createFlowFor(product: medicine)
        root.pushViewController(viewController, animated: true)
    }
}
