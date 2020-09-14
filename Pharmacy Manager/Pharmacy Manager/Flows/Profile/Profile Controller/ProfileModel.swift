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

}

protocol ProfileModelOutput: class {
    func networkingDidComplete(errorText: String?)
}

class ProfileModel: Model {

    weak var output: ProfileModelOutput!

}

extension ProfileModel: ProfileModelInput, ProfileViewControllerOutput {

}
