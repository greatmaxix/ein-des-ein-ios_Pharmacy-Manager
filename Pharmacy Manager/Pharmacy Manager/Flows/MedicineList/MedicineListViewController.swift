//
//  MedicineListViewController.swift
//  Pharmacy
//
//  Created by Anton Bal’ on 12.08.2020.
//  Copyright © 2020 pharmacy. All rights reserved.
//

import UIKit
import MBProgressHUD

protocol MedicineListViewControllerInput: MedicineListModelOutput {}
protocol MedicineListViewControllerOutput: MedicineListModelInput {}

final class MedicineListViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var productCountLabel: UILabel!
    
    // MARK: - Properties
    var model: MedicineListViewControllerOutput!
    
    private lazy var activityIndicator: MBProgressHUD = {
        setupActivityIndicator()
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        maskNavigation()
        configUI()
        setupTableView()
        activityIndicator.show(animated: true)
        model.load()
    }
}

// MARK: - Private
extension MedicineListViewController {
    
    private func configUI() {
        title = model.title
    }
    
    private func setupTableView() {
        tableView.separatorInset = GUI.separatorInset
        tableView.separatorColor = GUI.separatorColor
        tableView.backgroundColor = Asset.LegacyColors.lightGray.color
        tableView.register(cellType: MedicineCell.self)
    }
}

// MARK: - FarmacyListViewControllerInput
extension MedicineListViewController: MedicineListViewControllerInput {
    
    func retrivesNewResults() {
        productCountLabel.attributedText = titleAttributed(count: model.totalNumberOfItems)
        activityIndicator.hide(animated: true)
        tableView.reloadData()
    }
    
    func retreivingMoreMedicinesDidEnd() {
        activityIndicator.hide(animated: true)
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
}

// MARK: - UITableViewDataSource
extension MedicineListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.medicines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(at: indexPath, cellType: MedicineCell.self)
        cell.apply(medicine: model.medicines[indexPath.row])
        
        if model.isEndOfList == false && indexPath.row == model.medicines.count - 1 {
            activityIndicator.show(animated: true)
            model.retreiveMoreMedecines()
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MedicineListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        model.didSelectProductBy(indexPath: indexPath)
    }
}

// MARK: - Multiple attributes string

extension MedicineListViewController {
    
    fileprivate func titleAttributed(count: Int) -> NSAttributedString {
        let foundText = L10n.MedicineList.foundedTitle
        let countText = "\(count)"
        let productText = count == 1 ?  L10n.MedicineList.foundedTitleBodySingle : L10n.MedicineList.foundedTitleBodyMany
        let text = "\(foundText) \(countText) \(productText)"
        
        let countFont = FontFamily.OpenSans.bold.font(size: 16)
        let font =  FontFamily.OpenSans.regular.font(size: 14)
        let color = Asset.LegacyColors.textDarkBlue.color
        
        let att = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.font: font, .foregroundColor: color])
        att.addAttribute(.font, value: countFont, range: NSRange(location: foundText.count + 1, length: countText.count))
        
        return att
    }
}

// MARK: - External declaration
extension MedicineListViewController {
    
    enum GUI {
        static let sortButtonImagePadding: CGFloat = 9
        static let separatorInset = UIEdgeInsets.only(left: 135)
        static let separatorColor = Asset.LegacyColors.applyBlueGray.color.withAlphaComponent(0.2)
    }
}

extension UIViewController {
    func maskNavigation() {
        guard navigationController?.isNavigationBarHidden ?? true == false else { return }
        let background = UIView()
        background.backgroundColor = Asset.LegacyColors.welcomeBlue.color
        background.layer.cornerRadius = 10.0
        background.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        background.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(background)
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: view.topAnchor),
            background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            background.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        view.bringSubviewToFront(background)
    }
}
