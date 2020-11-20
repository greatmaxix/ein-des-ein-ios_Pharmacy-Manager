//
//  NeedHelpViewController.swift
//  Pharmacy Manager
//
//  Created by Sergey berdnik on 20.11.2020.
//  Copyright © 2020 PharmacyManager. All rights reserved.
//

import UIKit
import MBProgressHUD

protocol NeedHelpViewControllerInput: NeedHelpModelOutput {}
protocol NeedHelpViewControllerOutput: NeedHelpModelInput {}

class NeedHelpViewController: UIViewController {
    
    // MARK: - @IBOutlets & Properties
    @IBOutlet private weak var tableView: UITableView!
    
    private lazy var activityIndicator: MBProgressHUD = {
        setupActivityIndicator()
    }()
    
    var model: NeedHelpViewControllerOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
    }
    
    // MARK: - Setup TableView
    private func setupTableView() {
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: String(describing: ProfileViewControllerViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ProfileViewControllerViewCell.self))
        tableView.register(EmptyTableViewCell.self, forCellReuseIdentifier: String(describing: EmptyTableViewCell.self))
    }
}

// MARK: - Model delegate extension
extension NeedHelpViewController: NeedHelpViewControllerInput {
    func reloadTableView() {
        UIView.transition(with: tableView,
                          duration: 0.35,
                          options: .transitionCrossDissolve,
                          animations: {[weak self] in
                            self?.tableView.reloadData() })
    }
}

// MARK: - Talbeview DataSource & Delegate extension
extension NeedHelpViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData: ProfileBaseCellData = model.cellDataAt(index: indexPath.row)
        if let cell: ProfileBaseTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellData.nibName!, for: indexPath) as? ProfileBaseTableViewCell {
            
            cell.setup(cellData: cellData)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return model.cellDataAt(index: indexPath.row).cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? ProfileBaseTableViewCell else {return}
        cell.isApplyState.toggle()
        print("zxcv \(cell.isApplyState)")
        model.selectActionAt(index: indexPath.row, cellState: cell.isApplyState)?()
    }
}

