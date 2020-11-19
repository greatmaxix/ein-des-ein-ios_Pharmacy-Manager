//
//  HomeModel.swift
//  Pharmacy Manager
//
//  Created by Mikhail Timoscenko on 11.09.2020.
//  Copyright © 2020 PharmacyManager. All rights reserved.
//

import Foundation
import EventsTree

enum HomeEvent: Event {
    case openSearch
}

protocol HomeModelInput: class {
    func openSearch()
}

protocol HomeModelOutput: class {
    func networkingDidComplete(errorText: String?)
}

class HomeModel: Model {

    weak var output: HomeModelOutput!

}

extension HomeModel: HomeModelInput, HomeViewControllerOutput {

    func openSearch() {
        raise(event: HomeEvent.openSearch)
    }

}
