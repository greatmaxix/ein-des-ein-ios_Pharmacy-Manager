//
//  AboutAppModel.swift
//  Pharmacy Manager
//
//  Created by Sergey berdnik on 20.11.2020.
//  Copyright © 2020 PharmacyManager. All rights reserved.
//

import Foundation
import EventsTree

protocol AboutAppModelInput: class {
    var cellCount: Int { get }
    func cellDataAt(index: Int) -> ProfileBaseCellData
    func selectActionAt(index: Int) -> EmptyClosure?
}

protocol AboutAppModelOutput: class {
    
}


class AboutAppModel: Model {
    
    private var cellsData: [ProfileBaseCellData] = []
    
    weak var output: AboutAppModelOutput!
    private let localizedStrings = L10n.ProfileScreen.AboutApp.self
    
    override init(parent: EventNode?) {
        super.init(parent: parent)

        setupCellData()
    }
    
    private func setupCellData() {
        cellsData = []
        
        do {
            let cellData = AboutAppHeaderViewCellData()
            cellsData.append(cellData)
        }
        
        do {
            let cellData = ProfileViewControllerCellData(imageName: "profileArrangement",
                                                         title: localizedStrings.profileArrangement)
                cellsData.append(cellData)
        }
        
        do {
            let cellData = ProfileViewControllerCellData(imageName: "profileAboutPersonalData",
                                                         title: localizedStrings.personalData)
                cellsData.append(cellData)
        }
        
        do {
            let cellData = ProfileViewControllerCellData(imageName: "profileTermsDataUse",
                                                         title: localizedStrings.termsDataUse)
                cellsData.append(cellData)
        }
        
        do {
            let cellData = ProfileViewControllerCellData(imageName: "profileAboutCashBack",
                                                         title: localizedStrings.cashBack)
                cellsData.append(cellData)
        }
    }
}

extension AboutAppModel: AboutAppModelInput, AboutAppViewControllerOutput {
    func selectActionAt(index: Int) -> EmptyClosure? {
            cellsData[index].selectHandler
    }
    
    func cellDataAt(index: Int) -> ProfileBaseCellData {
        return cellsData[index]
    }
    
    var cellCount: Int {
        cellsData.count
    }
}
