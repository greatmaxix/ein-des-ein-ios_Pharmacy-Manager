//
//  NotificationViewController.swift
//  Pharmacy Manager
//
//  Created by Sergey berdnik on 19.11.2020.
//  Copyright © 2020 PharmacyManager. All rights reserved.
//

import UIKit
import MBProgressHUD


protocol NotificationViewControllerInput: NotificationModelOutput {}
protocol NotificationViewControllerOutput: NotificationModelInput {}

class NotificationViewController: UIViewController {
    
    // MARK: - @IBOutlets & Properties
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var navBarView: NavigationBarView!
    
    private lazy var activityIndicator: MBProgressHUD = {
        setupActivityIndicator()
    }()
    
    private enum GUI {
        static let cellHeight: CGFloat = 65.0
        static let emptyCellHeight: CGFloat = 35
    }
    
    var model: NotificationViewControllerOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavBar()
    }
    
    private func setupTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.register(UINib(nibName: "NotificationViewCell", bundle: nil), forCellReuseIdentifier: "NotificationViewCell")
        self.tableView.register(UINib(nibName: "EmptyTableViewCell", bundle: nil), forCellReuseIdentifier: "EmptyTableViewCell")
    }
    
    private func setupNavBar(){
        navigationController?.isNavigationBarHidden = true
        navBarView.setupBar(backButtonText: "Профиль", titleText: "Уведомления", backButtonAction: { [weak self] in
            self?.model.back()
        })
    }
}

// MARK: - Model delegate extension
extension NotificationViewController: NotificationViewControllerInput {}

// MARK: - Talbeview DataSource & Delegate extension
extension NotificationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 2 {
            return GUI.emptyCellHeight
        } else {
            return GUI.cellHeight
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 2,
           let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyTableViewCell", for: indexPath) as? EmptyTableViewCell {
            let cellData = EmptyTableViewCellData.init(height: GUI.emptyCellHeight)
            cell.setup(cellData: cellData)
            return cell
        }
            
        if let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationViewCell", for: indexPath) as? NotificationViewCell {
            cell.setup(title: model.cellData[indexPath.row].0,
                       switchState: model.cellData[indexPath.row].1)
            return cell
            }
        return UITableViewCell()
        }
}
