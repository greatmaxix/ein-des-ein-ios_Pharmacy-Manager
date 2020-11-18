//
//  ProductCoordinator.swift
//  Pharmacy
//
//  Created by Anton Bal’ on 13.08.2020.
//  Copyright © 2020 pharmacy. All rights reserved.
//

import Foundation
import EventsTree
import CoreLocation
import MapKit

struct ProductFlowConfiguration {
    let parent: EventNode
    let navigation: UINavigationController
}

final class ProductCoordinator: EventNode, Coordinator {
    let navigation: UINavigationController
    
    func createFlow() -> UIViewController {
        fatalError()
    }
    
    func createFlowFor(product: Medicine) -> ProductViewController {
        let root =  StoryboardScene.Product.initialScene.instantiate()
        let model = ProductModel(product: product, parent: self)
        root.model = model
        model.output = root
        return root
    }
    
    init(configuration: ProductFlowConfiguration) {
        navigation = configuration.navigation
        super.init(parent: configuration.parent)
        addHandler(.onRaise) { [weak self] (event: ProductModelEvent) in
            
            guard let self = self else { return }
            
            switch event {
            case .openAnalogsFor, .openCatalogsFor:
                self.openMedicineList()
            }
        }
    }
}

fileprivate extension ProductCoordinator {
    
    func openMedicineList() {
        let viewController = StoryboardScene.Catalogue.medicineListViewController.instantiate()
        let model = MedicineListModel(parent: self)
        viewController.model = model
        model.output = viewController
        navigation.pushViewController(viewController, animated: true)
    }

}
