//
//  SearchController.swift
//  Pharmacy
//
//  Created by Egor Bozko on 02.11.2020.
//  Copyright © 2020 pharmacy. All rights reserved.
//

import UIKit

class SearchController: UISearchController {

    override var searchBar: UISearchBar {
        return super.searchBar
    }
    
    override init(searchResultsController: UIViewController?) {
        super.init(searchResultsController: searchResultsController)
        setupSearchBar()
        searchBar.placeholder = "Поиск"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSearchBar() {
        searchBar.searchBarStyle = .prominent
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.tintColor = Asset.LegacyColors.textDarkBlue.color
        }
        searchBar.tintColor = Asset.LegacyColors.textDarkBlue.color
        obscuresBackgroundDuringPresentation = false
        searchBar.setSearchFieldBackgroundImage(Asset.Images.Search.searchFieldActive.image, for: .normal)
    }
}
