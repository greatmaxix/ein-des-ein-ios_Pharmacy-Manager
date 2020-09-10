//
//  StateTextFieldConfiguration.swift
//  KyivPost
//
//  Created by Mikhail Timoscenko on 25.06.2020.
//  Copyright © 2020 KyivPost. All rights reserved.
//


import Foundation
import UIKit

struct StateTextFieldConfiguration {

    var validationType: StateTextField.StateTextFieldValidtionType?
    var keyboardType: UIKeyboardType?
    var isSecure: Bool?

    static func phoneConfiguration() -> StateTextFieldConfiguration {
        var configuration = StateTextFieldConfiguration()

        configuration.validationType = StateTextField.StateTextFieldValidtionType.phone
        configuration.keyboardType = .phonePad
        configuration.isSecure = false

        return configuration
    }

    static func textConfiguration() -> StateTextFieldConfiguration {
        var configuration = StateTextFieldConfiguration()

        configuration.validationType = StateTextField.StateTextFieldValidtionType.none
        configuration.keyboardType = .default
        configuration.isSecure = false

        return configuration
    }

    static func passwordConfiguration() -> StateTextFieldConfiguration {
        var configuration = StateTextFieldConfiguration()

        configuration.validationType = StateTextField.StateTextFieldValidtionType.password
        configuration.keyboardType = .default
        configuration.isSecure = true

        return configuration
    }

    static func emailConfiguration() -> StateTextFieldConfiguration {
        var configuration = StateTextFieldConfiguration()

        configuration.validationType = StateTextField.StateTextFieldValidtionType.email
        configuration.keyboardType = .emailAddress
        configuration.isSecure = false

        return configuration
    }

    static func firstNameConfiguration() -> StateTextFieldConfiguration {
        var configuration = StateTextFieldConfiguration()

        configuration.validationType = StateTextField.StateTextFieldValidtionType.nonEmpty
        configuration.keyboardType = .default
        configuration.isSecure = false

        return configuration
    }

    static func lastNameConfiguration() -> StateTextFieldConfiguration {
        var configuration = StateTextFieldConfiguration()

        configuration.validationType = StateTextField.StateTextFieldValidtionType.nonEmpty
        configuration.keyboardType = .default
        configuration.isSecure = false

        return configuration
    }

}
