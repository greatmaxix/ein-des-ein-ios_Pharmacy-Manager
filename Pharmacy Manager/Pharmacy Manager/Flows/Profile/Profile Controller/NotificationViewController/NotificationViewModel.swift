//
//  NotificationViewModel.swift
//  Pharmacy Manager
//
//  Created by Sergey berdnik on 19.11.2020.
//  Copyright © 2020 PharmacyManager. All rights reserved.
//

import Foundation
import EventsTree

protocol NotificationModelInput: class {
    var cellCount: Int { get }
    var cellData: [(String,Bool)] {get}
}

protocol NotificationModelOutput: class {
    
}

class NotificationModel: Model {
    
    weak var output: NotificationModelOutput!
    
    override init(parent: EventNode?) {
        super.init(parent: parent)
    }
}

extension NotificationModel: NotificationModelInput, NotificationViewControllerOutput {
    var cellData: [(String, Bool)] {
        return [("Push уведомления", true),
                ("Email рассылка", true),
                ("test", true),
                ("Новый запрос в чате", true),
                ("Обновление рейтинга", false)]
    }
    
    var cellCount: Int {
        5
    }
}
    

