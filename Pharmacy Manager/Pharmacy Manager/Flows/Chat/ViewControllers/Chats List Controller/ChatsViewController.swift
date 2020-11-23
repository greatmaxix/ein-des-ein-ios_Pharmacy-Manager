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

class ChatsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var searchController = SearchController(searchResultsController: nil)
    
    var model: ChatsViewControllerOutput!
    
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
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        title = L10n.Tabbar.chat
    }
    
    @objc func showSearch() {
        
    }
    
    func hideSearch() {
        
    }
}
    
extension ChatsViewController: ChatsViewControllerInput {

    func networkingDidComplete(errorText: String?) {
        hideActivityIndicator()
        tableView.reloadData()
    }
}

extension ChatsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatTableViewCell.reuseIdentifier)
        (cell as? ChatTableViewCell)?.apply(chat: model.items[indexPath.row])
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        model.didSelect(indexPath)
    }
}

extension ChatsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
}
