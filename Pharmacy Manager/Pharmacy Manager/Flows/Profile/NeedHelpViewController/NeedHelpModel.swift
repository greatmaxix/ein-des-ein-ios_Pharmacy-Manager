//
//  NeedHelpModel.swift
//  Pharmacy Manager
//
//  Created by Sergey berdnik on 20.11.2020.
//  Copyright © 2020 PharmacyManager. All rights reserved.
//

import Foundation
import EventsTree

protocol NeedHelpModelInput: class {
    var cellCount: Int { get }
    func cellDataAt(index: Int) -> ProfileBaseCellData
    func selectActionAt(index: Int, cellState: Bool) -> EmptyClosure?
}

protocol NeedHelpModelOutput: class {
    func reloadTableView()
}

class NeedHelpModel: Model {
    
    private var cellsData: [ProfileBaseCellData] = []
    weak var output: NeedHelpModelOutput!
    
    override init(parent: EventNode?) {
        super.init(parent: parent)

        setupCellData()
    }
    
    private func setupCellData() {
        cellsData = []
        
        do {
            let cellData = ProfileViewControllerCellData(imageName: "helpUsCashDiscipline",
                                                         title: "Кассовая дисциплина")
                cellsData.append(cellData)
        }
        
        do {
            let cellData = ProfileViewControllerCellData(imageName: "helpUsReturn",
                                                         title: "Возврат")
            cellsData.append(cellData)
        }
        
        do {
            let cellData = ProfileViewControllerCellData(imageName: "helpUsPrescription",
                                                         title: "Рецептурные товары")
                cellsData.append(cellData)
        }
        
        do {
            let cellData = ProfileViewControllerCellData(imageName: "helpUsTechicalProblems",
                                                         title: "Проблемы с оборудованием")
                cellsData.append(cellData)
        }
        
        do {
            let cellData = ProfileViewControllerCellData(imageName: "profileAddress",
                                                         title: "Доставка")
                cellsData.append(cellData)
        }
    }
}

extension NeedHelpModel: NeedHelpModelInput, NeedHelpViewControllerOutput {
    
    func selectActionAt(index: Int, cellState: Bool) -> EmptyClosure? {
        switch cellState {
        case true:
            let cellData = EmptyTableViewCellData.init(height: 40, color: .clear)
            self.cellsData.insert(cellData, at: index + 1)
        case false:
            self.cellsData.remove(at: index + 1)
        }
        output.reloadTableView()
        return cellsData[index].selectHandler
    }
    
    func cellDataAt(index: Int) -> ProfileBaseCellData {
        return cellsData[index]
    }
    
    var cellCount: Int {
        cellsData.count
    }
}
