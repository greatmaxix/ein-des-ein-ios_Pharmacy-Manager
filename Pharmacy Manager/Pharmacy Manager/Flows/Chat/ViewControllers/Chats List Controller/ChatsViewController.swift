//
//  ChatsViewController.swift
//  Pharmacy Manager
//
//  Created by Mikhail Timoscenko on 11.09.2020.
//  Copyright © 2020 PharmacyManager. All rights reserved.
//

import UIKit

protocol ChatsViewControllerInput: ChatsListModelOutput {}
protocol ChatsViewControllerOutput: ChatsListModelInput {}

class ChatsViewController: UIViewController, ChatsViewControllerInput {
    
    @IBOutlet weak var tableView: UITableView!
    
    var searchController = SearchController(searchResultsController: nil)
    
    var model: ChatsViewControllerOutput!

    internal var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        showActivityIndicator()
        model.load()
    }
    
    func setup() {
        tableView.register(ChatTableViewCell.nib, forCellReuseIdentifier: ChatTableViewCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 90.0
        tableView.backgroundColor = Asset.LegacyColors.lightGray.color
        tableView.tableFooterView = UIView()
        
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        title = L10n.Tabbar.chat
    }
}
    
extension ChatsViewController {
    
    var searchTerm: String {
        return searchController.searchBar.text ?? ""
    }
    
    func didFilterItems() {
        tableView.reloadData()
    }
    
    func networkingDidComplete(errorText: String?) {
        hideActivityIndicator()
        tableView.reloadData()
    }
}

extension ChatsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearchBarEmpty ? model.items.count : model.filteredItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatTableViewCell.reuseIdentifier)
        let item = (isSearchBarEmpty ? model.items : model.filteredItems)[indexPath.row]
        (cell as? ChatTableViewCell)?.apply(chat: item)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        model.didSelect(indexPath)
    }
}

extension ChatsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
}

extension ChatsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        self.model.searchChat(searchController.searchBar.text ?? "")
    }
}

extension ChatsViewController: UISearchControllerDelegate {
    
}
