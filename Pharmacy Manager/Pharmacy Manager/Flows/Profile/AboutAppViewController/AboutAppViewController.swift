//
//  AboutAppViewController.swift
//  Pharmacy Manager
//
//  Created by Sergey berdnik on 20.11.2020.
//  Copyright © 2020 PharmacyManager. All rights reserved.
//

import UIKit
import MBProgressHUD

protocol AboutAppViewControllerInput: AboutAppModelOutput {}
protocol AboutAppViewControllerOutput: AboutAppModelInput {}

class AboutAppViewController: UIViewController {
    
    // MARK: - @IBOutlets & Properties
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var navBarView: NavigationBarView!
    
    private lazy var activityIndicator: MBProgressHUD = {
        setupActivityIndicator()
    }()
    
    var model: AboutAppViewControllerOutput!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
            return UIStatusBarStyle.lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupNavBar()
    }

    private func setupTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: String(describing: AboutAppHeaderViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: AboutAppHeaderViewCell.self))
        tableView.register(UINib(nibName: String(describing: ProfileViewControllerViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ProfileViewControllerViewCell.self))
    }
    
    private func setupNavBar(){
        navigationController?.isNavigationBarHidden = true
        navBarView.setupBar(backButtonText: L10n.ProfileScreen.title,
                            titleText: L10n.ProfileScreen.AboutApp.title,
                            backButtonAction: {[weak self] in
            self?.model.back()
        })
    }
}

// MARK: - Model delegate extension
extension AboutAppViewController: AboutAppViewControllerInput {}

extension AboutAppViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return model.cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellData: ProfileBaseCellData = model.cellDataAt(index: indexPath.row)
        
        if let cell: ProfileBaseTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellData.nibName!, for: indexPath) as? ProfileBaseTableViewCell {
            cell.setup(cellData: cellData)
            
            if let cellWithURL = cell as? AboutAppHeaderViewCell {
                // FIXME: - Nead get URL for action and realize in this block
                cellWithURL.urlTappedActionHandler = {
                    guard let url = URL(string: "kzpharamcy.com") else { return }
                    UIApplication.shared.canOpenURL(url)
                }
            }
            
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
