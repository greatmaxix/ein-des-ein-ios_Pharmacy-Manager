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
    @IBOutlet private weak var navBarView: NavigationBarView!
    
    private lazy var activityIndicator: MBProgressHUD = {
        setupActivityIndicator()
    }()

    var model: ProfileViewControllerOutput!

    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavBar()
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
    
    private func setupNavBar(){
        navigationController?.isNavigationBarHidden = true
        navBarView.setupBar(backButtonText: "", titleText: "Профиль")

        navBarView.backButtonIsHidden(state: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
}

// MARK: - Model delegate extension
extension ProfileViewController: ProfileViewControllerInput {
    func logoutAction() {
        let blurEffect = UIBlurEffect(style: .light)
        let blurVisualEffectView = UIVisualEffectView(effect: blurEffect)
        blurVisualEffectView.frame = view.bounds

        let alertController = UIAlertController.init(title: "Вы уверены, что хотите выйти из приложения?", message: " до тех пор пока не авторизирутесь снова", preferredStyle: .alert)
        
        let actionOK = UIAlertAction(title: "Отмена", style: .default, handler: { _ in blurVisualEffectView.removeFromSuperview()})

        let actionCancel = UIAlertAction(title: "Выйти", style: .default, handler: {[unowned self] _ in
            blurVisualEffectView.removeFromSuperview()
            self.model.logoutActionCofirmed()
        })

        actionCancel.titleTextColor = .red
        alertController.addAction(actionOK)
        alertController.addAction(actionCancel)
        alertController.preferredAction = actionCancel
        self.view.addSubview(blurVisualEffectView)
        self.present(alertController, animated: true, completion: nil)
    }
    
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
            
            // FIXME: - Удалить после создания запроса и получения результата по статистике
            if let data = cellData as? ProfileViewControllerCellData,
               data.title == "Статистика" {
                cell.deactivateCell()
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
