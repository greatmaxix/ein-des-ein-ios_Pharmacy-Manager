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
    func back()
}

protocol NeedHelpModelOutput: class {
    func reloadTableView()
}

class NeedHelpModel: Model {
    
    private var cellsData: [ProfileBaseCellData] = []
    weak var output: NeedHelpModelOutput!
    private let localizedStrings = L10n.ProfileScreen.HaveQuestions.self
    
    private var stringsArray: [String]!
    
    override init(parent: EventNode?) {
        super.init(parent: parent)

        setupCellsBody()
        setupCellData()
    }
    
    private func setupCellsBody() {
        stringsArray = ["1 - \(localizedStrings.cashDisciplineBodyText)",
                        "2 - \(localizedStrings.cashDisciplineBodyText)",
                        "3 - \(localizedStrings.cashDisciplineBodyText)",
                        "4 - \(localizedStrings.cashDisciplineBodyText)",
                        "5 - \(localizedStrings.cashDisciplineBodyText)"]
    }
    
    private func setupCellData() {
        cellsData = []
        
        do {
            let cellData = ProfileViewControllerCellData(imageName: "helpUsCashDiscipline",
                                                         title: localizedStrings.cashDiscipline)
                cellsData.append(cellData)
        }
        
        do {
            let cellData = ProfileViewControllerCellData(imageName: "helpUsReturn",
                                                         title: localizedStrings.back)
            cellsData.append(cellData)
        }
        
        do {
            let cellData = ProfileViewControllerCellData(imageName: "helpUsPrescription",
                                                         title: localizedStrings.receiptGoods)
                cellsData.append(cellData)
        }
        
        do {
            let cellData = ProfileViewControllerCellData(imageName: "helpUsTechicalProblems",
                                                         title: localizedStrings.techicalProblems)
                cellsData.append(cellData)
        }
        
        do {
            let cellData = ProfileViewControllerCellData(imageName: "profileAddress",
                                                         title: localizedStrings.delivery)
                cellsData.append(cellData)
        }
    }
}

extension NeedHelpModel: NeedHelpModelInput, NeedHelpViewControllerOutput {

    func back() {
        raise(event: ProfileEvent.back)
    }
    
    func selectActionAt(index: Int, cellState: Bool) -> EmptyClosure? {
        switch cellState {
        case true:
            let cellData = NeedHelpViewCellData.init(bodyText: stringsArray[index])
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
