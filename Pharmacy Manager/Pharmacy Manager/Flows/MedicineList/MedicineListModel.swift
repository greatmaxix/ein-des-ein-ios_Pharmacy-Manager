//
//  MedicineListModel.swift
//  Pharmacy
//
//  Created by Anton Bal’ on 12.08.2020.
//  Copyright © 2020 pharmacy. All rights reserved.
//

import Foundation
import EventsTree

enum MedicineListModelEvent: Event {
    case openProduct(Medicine)
}

protocol MedicineListModelInput: class {
    var isEndOfList: Bool { get }
    var medicines: [Medicine] { get }
    var title: String { get }
    var totalNumberOfItems: Int { get }
    func load()
    func retreiveMoreMedecines()
    func didSelectProductBy(indexPath: IndexPath)
}

protocol MedicineListModelOutput: class {
    func retrivesNewResults()
    func retreivingMoreMedicinesDidEnd()
    func needToInsertNewMedicines(at: [IndexPath]?)
}

final class MedicineListModel: Model {
    
    // MARK: - Properties
    weak var output: MedicineListModelOutput!
    
    private(set) var medicines: [Medicine] = []
    private(set) var totalNumberOfItems: Int = 0
    var title: String {
        self.category?.shortTitle ?? ""
    }
    
    private var category: Category?
    private let provider = DataManager<SearchAPI, ListContainerResponse<Medicine>>()
    private let wishListProvider = DataManager<WishListAPI, PostResponse>()
    private var pageNumber: Int = 1
    var isEndOfList = false
    
    private lazy var userRegionId: Int = {
        UserDefaultsAccessor.value(for: \.regionId)
    }()
    
    // MARK: - Init / Deinit methods
    init(category: Category? = nil, parent: EventNode?) {
        self.category = category
        super.init(parent: parent)
    }
    
    /**
            Init for setup model from medicine detail screen from homeFlow
            - Parameter product: enter product object for setup model
     */
    init(product: Product, parent: EventNode?) {
        self.category = Category(title: product.activeSubstances.first ?? "",
                                 imageURL: nil)
        super.init(parent: parent)
    }
}

// MARK: - Private methods
extension MedicineListModel {
    
    func retreiveMoreMedecines() {
        retreiveMedecines(on: pageNumber + 1) { [weak output] in
            output?.retreivingMoreMedicinesDidEnd()
        }
    }
    
    private func retreiveMedecines() {
        pageNumber = 1
        medicines = []
        retreiveMedecines(on: pageNumber, pageSize: .firstPageSize)
    }
    
    private func retreiveMedecines(on page: Int,
                                   pageSize: Int = .pageSize,
                                   completion: (() -> Void)? = nil) {
        
        guard isEndOfList == false else {
            return
        }
        provider.load(target: .searchByName(name: "",
                                            regionId: userRegionId,
                                            categoryCode: category?.code,
                                            pageNumber: page,
                                            itemsOnPage: pageSize)) { [weak self] response in
            guard let self = self else {
                return
            }

            switch response {
            case .success(let result):

                if pageSize > result.entities.count {
                    self.isEndOfList = true
                }

                self.pageNumber = result.currentPage
                self.totalNumberOfItems = result.totalNumberOfItems
                self.medicines.append(contentsOf: result.entities)
                if self.pageNumber == 1 {
                    self.output.retrivesNewResults()
                } else if self.pageNumber > 1 {
                    let startIndex = self.medicines.count - result.entities.count
                    let endIndex = startIndex + result.entities.count
                    let indexPathesToInsert = (startIndex..<endIndex).map {
                        IndexPath(row: $0, section: 0)
                    }

                    self.output.needToInsertNewMedicines(at: indexPathesToInsert)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }

            completion?()
        }
    }
}

// MARK: - FarmacyListViewControllerOutput
extension MedicineListModel: MedicineListViewControllerOutput {
    
    func didSelectProductBy(indexPath: IndexPath) {
        guard indexPath.row <= medicines.endIndex else {
            return
        }
        
        raise(event: MedicineListModelEvent.openProduct(medicines[indexPath.row]))
    }
    
    func load() {
        retreiveMedecines()
    }
}

private extension Int {
    static let firstPageSize: Int = 20
    static let pageSize: Int = 10
}
