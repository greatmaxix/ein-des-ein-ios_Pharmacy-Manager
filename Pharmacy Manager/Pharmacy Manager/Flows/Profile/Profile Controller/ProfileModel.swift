//
//  ProfileModel.swift
//  Pharmacy Manager
//
//  Created by Mikhail Timoscenko on 11.09.2020.
//  Copyright © 2020 PharmacyManager. All rights reserved.
//

import Foundation
import EventsTree

enum ProfileEvent: Event {
    case userSignedIn
}

protocol ProfileModelInput: class {
    var cellCount: Int { get }
    func cellDataAt(index: Int) -> ProfileBaseCellData
    func selectActionAt(index: Int) -> EmptyClosure?
}

protocol ProfileModelOutput: class {
    func networkingDidComplete(errorText: String?)
}

class ProfileModel: Model {
    private var cellsData: [ProfileBaseCellData] = []
    //private var user: UserDisplayable?
    //private let provider = DataManager<ProfileAPI, ProfileResponse>()
    weak var output: ProfileModelOutput!
    
    override init(parent: EventNode?) {
        super.init(parent: parent)

        setupCellData()
    }

    private func setupCellData() {
        cellsData = []
        do {
            let cellData: ProfilePersonalInfoData = ProfilePersonalInfoData(imageUrl: nil, name: "Тимофей лекарь", email: "ТимофейЛекарь@mail.com", score: "5.0")
                cellsData.append(cellData)
        }
        
        do {
            let cellData: EmptyTableViewCellData = EmptyTableViewCellData(height: 24.5, color: .clear)
            cellsData.append(cellData)
        }

        do {
            let cellData: ProfileViewControllerCellData = ProfileViewControllerCellData(imageName: "profileStatistic",
                                                                                        title: "Статистика")
                cellsData.append(cellData)
        }
        
        do {
            let cellData: ProfileViewControllerCellData = ProfileViewControllerCellData(imageName: "profileBell on",
                                                                                        title: "Уведомления")
                cellsData.append(cellData)
        }
        
        do {
            let cellData: EmptyTableViewCellData = EmptyTableViewCellData(height: 32, color: .clear)
            cellsData.append(cellData)
        }
        
        do {
            let cellData: ProfileViewControllerCellData = ProfileViewControllerCellData(imageName: "profileAttension",
                                                                                        title: "О приложении")
                cellsData.append(cellData)
        }
        
        do {
            let cellData: ProfileViewControllerCellData = ProfileViewControllerCellData(imageName: "profileQuestion",
                                                                                        title: "Нужна помощь?")
                cellsData.append(cellData)
        }
        
        do {
            let cellData: EmptyTableViewCellData = EmptyTableViewCellData(height: 40, color: .clear)
            cellsData.append(cellData)
        }
        
        do {
            let cellData: ProfileViewControllerCellData = ProfileViewControllerCellData(imageName: "profileQuit",
                                                                                        title: "Выйти из аккаунта")
                cellsData.append(cellData)
        }
    }
}

extension ProfileModel: ProfileModelInput, ProfileViewControllerOutput {
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

