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
    case presentAboutAppViewController
    case pushNotificationViewController
    case presentNeedHelpViewController
    case logout
}

protocol ProfileModelInput: class {
    var cellCount: Int { get }
    func cellDataAt(index: Int) -> ProfileBaseCellData
    func selectActionAt(index: Int) -> EmptyClosure?
    func logoutActionCofirmed()
}

protocol ProfileModelOutput: class {
    func networkingDidComplete(errorText: String?)
    func logoutAction()
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
        if let user = UserSession.shared.user {
            
        do {
            let cellData = ProfilePersonalInfoData(imageUrl: user.avatarURL,
                                                   name: user.name,
                                                   email: user.email ?? "",
                                                   score: "5.0")
                cellsData.append(cellData)
        }
        
        do {
            let cellData = EmptyTableViewCellData(height: 24.5, color: .clear)
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
            cellData.selectHandler = {[weak self] in
                self?.raise(event: ProfileEvent.pushNotificationViewController)
            }
            
            cellsData.append(cellData)
        }
        
        do {
            let cellData = EmptyTableViewCellData(height: 32, color: .clear)
            cellsData.append(cellData)
        }
        
        do {
            let cellData = ProfileViewControllerCellData(imageName: "profileAttension",
                                                         title: "О приложении")
            
            cellData.selectHandler = {[weak self] in
                self?.raise(event: ProfileEvent.presentAboutAppViewController)
            }
            
            cellsData.append(cellData)
        }
        
        do {
            let cellData: ProfileViewControllerCellData = ProfileViewControllerCellData(imageName: "profileQuestion",
                                                                                        title: "Нужна помощь?")
            cellData.selectHandler = {[weak self] in
                self?.raise(event: ProfileEvent.presentNeedHelpViewController)
            }
            
            cellsData.append(cellData)
        }
        
        do {
            let cellData = EmptyTableViewCellData(height: 40, color: .clear)
            cellsData.append(cellData)
        }
        
        do {
            let cellData = ProfileViewControllerCellData(imageName: "profileQuit",
                                                         title: "Выйти из аккаунта",
                                                         tintColor: .red)
            cellData.selectHandler = {[weak self] in
                self?.output.logoutAction()
            }
                cellsData.append(cellData)
            }
        }
    }
}

extension ProfileModel: ProfileModelInput, ProfileViewControllerOutput {
    func logoutActionCofirmed() {
        guard let token = KeychainManager.shared.getToken() else { return }
        // FIXME: - Nead realized network request to server
        UserSession.shared.logout()
        self.raise(event: ProfileEvent.logout)
    }
    
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

