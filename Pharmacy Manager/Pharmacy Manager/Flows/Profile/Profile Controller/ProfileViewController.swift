//
//  ProfileViewController.swift
//  Pharmacy Manager
//
//  Created by Mikhail Timoscenko on 11.09.2020.
//  Copyright © 2020 PharmacyManager. All rights reserved.
//

import UIKit
import MBProgressHUD

protocol ProfileViewControllerInput: ProfileModelOutput {}
protocol ProfileViewControllerOutput: ProfileModelInput {}

class ProfileViewController: UIViewController {
    
    // MARK: - @IBOutlets & Properties
    @IBOutlet private weak var tableView: UITableView!
    
    private lazy var activityIndicator: MBProgressHUD = {
        setupActivityIndicator()
    }()

    var model: ProfileViewControllerOutput!

    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        //activityIndicator.show(animated: true)
    }

    // MARK: - Setup TableView
    private func setupTableView() {
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: String(describing: ProfilePersonalInfoViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ProfilePersonalInfoViewCell.self))
        tableView.register(UINib(nibName: String(describing: ProfileViewControllerViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ProfileViewControllerViewCell.self))
        
        tableView.register(EmptyTableViewCell.self, forCellReuseIdentifier: String(describing: EmptyTableViewCell.self))

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
}

// MARK: - Model delegate extension
extension ProfileViewController: ProfileViewControllerInput {
    func networkingDidComplete(errorText: String?) {

    }

}

// MARK: - Talbeview DataSource & Delegate extension
extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData: ProfileBaseCellData = model.cellDataAt(index: indexPath.row)
        if let cell: ProfileBaseTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellData.nibName!, for: indexPath) as? ProfileBaseTableViewCell {
            if let data = cellData as? ProfileViewControllerCellData,data.title == "Статистика" {
                cell.disactivateCell()
            }
            cell.setup(cellData: cellData)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return model.cellDataAt(index: indexPath.row).cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        model.selectActionAt(index: indexPath.row)?()
    }
}
