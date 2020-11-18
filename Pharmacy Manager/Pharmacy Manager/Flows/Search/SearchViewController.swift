//
//  SearchViewController.swift
//  Pharmacy
//
//  Created by Anton Bal’ on 07.08.2020.
//  Copyright © 2020 pharmacy. All rights reserved.
//

import UIKit
import MBProgressHUD

protocol SearchViewControllerInput: SearchModelOutput {}
protocol SearchViewControllerOutput: SearchModelInput {}

final class SearchViewController: UIViewController, NavigationBarStyled {

    private enum GUI {
        static let backgroundColor = Asset.LegacyColors.welcomeBlue.color.withAlphaComponent(0.1)
        static let textColor = Asset.LegacyColors.welcomeBlue.color
        static let textFont = UIFont.systemFont(ofSize: 14)
    }
    
    @IBOutlet private weak var cleanButton: UIButton!
    @IBOutlet private weak var storyLabel: UILabel!
    @IBOutlet private weak var headerView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var emptyView: EmptySearchView!
    
    private let searchBar = SearchBar()
    
    private lazy var activityIndicator: MBProgressHUD = {
        let hud = MBProgressHUD(view: view)
        hud.backgroundView.style = .solidColor
        hud.backgroundView.color = UIColor.black.withAlphaComponent(0.2)
        hud.removeFromSuperViewOnHide = false
        view.addSubview(hud)
        
        return hud
    }()
    
    var style: NavigationBarStyle = .search
    
    var model: SearchViewControllerOutput!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupTableView()
        setupNavigationBar()
        model.load()
    }
    
    func configUI() {
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delegate = self
    }

}

// MARK: - Private methods
extension SearchViewController {
    
    private func setupNavigationBar() {
        guard let navigationBar = navigationController?.navigationBar else {
            return
        }
        
        navigationBar.tintColor = .white
        navigationBar.backgroundColor = .clear
        navigationBar.setBackgroundImage(Asset.Images.Common.navigationBar.image.stretchableImage(withLeftCapWidth: 20,
                                                                                   topCapHeight: 20),
                                         for: .default)
        navigationBar.shadowImage = UIImage()

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Asset.Images.Welcome.barcode.image, style: .plain, target: self, action: nil)
        
        navigationItem.rightBarButtonItem?.action = #selector(tapScan)
        
        searchBar.delegate = self
        
        searchBar.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        navigationItem.titleView = searchBar
        searchBar.topAnchor.constraint(equalTo: searchBar.superview!.topAnchor).isActive = true
        searchBar.bottomAnchor.constraint(equalTo: searchBar.superview!.bottomAnchor, constant: -8.0).isActive = true
    }
    
    private func setupTableView() {
        tableView.register(cellType: SearchTableViewCell.self)
        tableView.register(cellType: MedicineCell.self)
    }
    
    @objc private func tapScan() {
        model.openScan()
    }
}

// MARK: - SearchViewControllerInput
extension SearchViewController: SearchViewControllerInput {
    
    func willSendRequest() {
        activityIndicator.show(animated: true)
    }
    
    func retrivesNewResults() {
        if case .empty = model.searchState {
            emptyView.isHidden = false
        } else {
            emptyView.isHidden = true
        }
        
        tableView.reloadData()
        
        activityIndicator.hide(animated: true)
    }
    
    func retreivingMoreMedicinesDidEnd() {
        activityIndicator.hide(animated: true)
    }
    
    func didLoadRecentRequests() {
        guard isViewLoaded else {
            return
        }
        
        tableView.reloadData()
    }
    
    func needToInsertNewMedicines(at indexPathes: [IndexPath]?) {
        guard let indexPathes = indexPathes else {
            tableView.isHidden = false
            tableView.reloadData()
            
            return
        }

        tableView.beginUpdates()
        tableView.insertRows(at: indexPathes,
                             with: .automatic)
        tableView.endUpdates()
    }
    
    func searchTermDidUpdated(_ term: String?) {
        searchBar.endEditing(false)
        searchBar.textField.text = term
    }
    
    func beginSearch() {
        self.searchBar.textField.becomeFirstResponder()
    }
}

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch model.searchState {
        case .found:
            return model.medicines.count
        default:
            return .zero
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch model.searchState {
        case .found:
            let cell = tableView.dequeueReusableCell(at: indexPath, cellType: MedicineCell.self)
            cell.apply(medicine: model.medicines[indexPath.row])

            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch model.searchState {
        default:
            return .zero
        }
    }
}

// MARK: - UITableViewDataSourcePrefetching
extension SearchViewController: UITableViewDataSourcePrefetching {

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard case .found = model.searchState else {
            return
        }
        
        let isEndOfList = indexPaths.contains {
            $0.row == model.medicines.count - 1
        }
        
        guard isEndOfList else {
            return
        }
        
        activityIndicator.show(animated: true)
        
        model.retreiveMoreMedecines()
    }
}

// MARK: - SearchBarDelegate
extension SearchViewController: SearchBarDelegate {
    
    func searchBar(_ searchBar: SearchBar, textDidChange searchText: String) {
        model.updateSearchTerm(searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: SearchBar) {
        searchBar.endEditing(false)
        model.processSearch()
    }
    
    func searchBarDidCancel() {
        model.cleanSearchTerm()
    }
}

// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        model.didSelectCellAt(indexPath: indexPath)
    }
}
