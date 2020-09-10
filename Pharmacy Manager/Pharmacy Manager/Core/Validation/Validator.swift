//
//  Validator.swift
//  KyivPost
//
//  Created by Mikhail Timoscenko on 25.06.2020.
//  Copyright © 2020 KyivPost. All rights reserved.
//

import Foundation

final class Validator {

  var errorMessage: String?

  private let rules: [ValidationRule]

  init(rules: [ValidationRule]) {
    self.rules = rules
  }

  func validate(_ value: String) -> Bool {
    for rule in rules {
      if !rule.validate(value) {
        errorMessage = rule.errorMessage
        return false
      }
    }
    errorMessage = nil
    return true
  }

}
