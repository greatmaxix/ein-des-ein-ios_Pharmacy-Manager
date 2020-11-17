//
//  ProductModel.swift
//  Pharmacy
//
//  Created by Anton Bal’ on 13.08.2020.
//  Copyright © 2020 pharmacy. All rights reserved.
//

import Foundation
import EventsTree
import CoreLocation
enum ProductModelEvent: Event {
    case openAnalogsFor(Product)
    case openCatalogsFor(Product)
}

protocol ProductModelInput: class {
    var dataSource: TableDataSource<ProductCellSection> { get }
    var title: String { get }

    func load()
    func didSelectCell(at indexPath: IndexPath)
    func addToWishList()
    func removeFromWishList()
}

protocol ProductModelOutput: class {
    func didLoad(product: Product)
    func addRemoveFromFavoriteError()
}

final class ProductModel: Model {
    
    weak var output: ProductModelOutput!
    private let medicine: Medicine
    private var product: Product!
    
    private let provider = DataManager<ProductAPI, SingleItemContainerResponse<Product>>()
    private let wishListProvider = DataManager<WishListAPI, PostResponse>()
    
    let dataSource = TableDataSource<ProductCellSection>()
    var searchTerm: String = ""
    
    init(product: Medicine, parent: EventNode?) {
        self.medicine = product
        super.init(parent: parent)
    }
}

// MARK: - ProductViewControllerOutput

extension ProductModel: ProductViewControllerOutput {
    
    func addToWishList() {
        wishListProvider.load(target: .addToWishList(medicineId: self.product.identifier)) { (result) in
            switch result {
            case .success:
                break
            case .failure(let error):
                print("error is \(error.localizedDescription)")
                self.output.addRemoveFromFavoriteError()
            }
        }
    }
    
    func removeFromWishList() {
        wishListProvider.load(target: .removeFromWishList(medicineId: self.product.identifier)) { (result) in
            switch result {
            case .success:
                break
            case .failure(let error):
                print("error is \(error.localizedDescription)")
                self.output.addRemoveFromFavoriteError()
                }
        }
    }
    
    var title: String {
        medicine.title
    }
    
    func load() {
        
        provider.load(target: .global(identifier: medicine.id)) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let product):
                self.product = product.item
                
                self.dataSource.cells = ProductCellSection.allSectionsFor(product: self.product)
                self.output.didLoad(product: self.product)
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func didSelectCell(at indexPath: IndexPath) {
        guard let cell = dataSource.cell(for: indexPath) else { return }
        
        switch cell {
        case .analog(let product):
            raise(event: ProductModelEvent.openAnalogsFor(product))
        case .category(let product):
            raise(event: ProductModelEvent.openCatalogsFor(product))
        default:
            return
        }
    }

}
