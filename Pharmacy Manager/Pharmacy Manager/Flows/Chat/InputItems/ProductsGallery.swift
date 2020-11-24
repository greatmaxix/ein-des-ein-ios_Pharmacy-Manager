//
//  ProductsGallery.swift
//  Pharmacy Manager
//
//  Created by Egor Bozko on 24.11.2020.
//  Copyright © 2020 PharmacyManager. All rights reserved.
//

import Foundation
import InputBarAccessoryView

final class ProductsGallery: UIView, InputItem {
    
    enum GaleryState {
        case closed, opened, large
        
        var contentHeight: CGFloat {
            switch self {
            case .closed: return 0.0
            case .opened: return 300.0
            case .large: return 500.0
            }
        }
    }
    
    struct GUI {
        static let size = CGSize(width: 30.0, height: 36.0)
        static let imageRect = CGRect(x: 12.0, y: 0.0, width: 26.0, height: 30.0)
    }

    var appearanceState = GaleryState.closed {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: frame.width, height: appearanceState.contentHeight)
    }

    var itemSize: CGSize {
        let width = (frame.width / 2.0) - 1
        return CGSize(width: width, height: width)
    }
    var searchItemSize: CGSize {
        return CGSize(width: frame.width, height: 136.0)
    }
  
    weak var actionsDelegate: AnyObject?
    
    var inputBarAccessoryView: InputBarAccessoryView?
    var parentStackViewPosition: InputStackView.Position?
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let searchTextField = UITextField()
    
    let searchTextFieldDecoration = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        
        backgroundColor = Asset.LegacyColors.lightGray.color
        
        searchTextFieldDecoration.backgroundColor = .white
        searchTextFieldDecoration.layer.cornerRadius = 18.0
        searchTextField.textColor = Asset.LegacyColors.textDarkBlue.color
        searchTextField.placeholder = "Поиск"
        
        collectionView.backgroundColor = .white
        
        searchTextFieldDecoration.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: frame.width)
        ])
        
        addSubview(searchTextFieldDecoration)
        
        NSLayoutConstraint.activate([
            searchTextFieldDecoration.topAnchor.constraint(equalTo: topAnchor, constant: 6.0),
            searchTextFieldDecoration.leftAnchor.constraint(equalTo: leftAnchor, constant: 16.0),
            searchTextFieldDecoration.rightAnchor.constraint(equalTo: rightAnchor, constant: -16.0),
            searchTextFieldDecoration.heightAnchor.constraint(equalToConstant: 36.0)
        ])
        
        addSubview(searchTextField)
        
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: searchTextFieldDecoration.topAnchor, constant: 6.0),
            searchTextField.leftAnchor.constraint(equalTo: searchTextFieldDecoration.leftAnchor, constant: 16.0),
            searchTextField.rightAnchor.constraint(equalTo: searchTextFieldDecoration.rightAnchor, constant: -16.0),
            searchTextField.bottomAnchor.constraint(equalTo: searchTextFieldDecoration.bottomAnchor, constant: -6.0)
        ])
        
        addSubview(collectionView)
        
        let bottomConstraint = collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6.0)
        bottomConstraint.priority = .defaultLow
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchTextFieldDecoration.bottomAnchor, constant: 6.0),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0.0),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0.0),
            bottomConstraint
        ])
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func textViewDidChangeAction(with textView: InputTextView) {}
    func keyboardSwipeGestureAction(with gesture: UISwipeGestureRecognizer) {}
    func keyboardEditingEndsAction() {}
    func keyboardEditingBeginsAction() {}
}

extension ProductsGallery: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}

extension ProductsGallery: UICollectionViewDelegate {
    
}



final class ProductGalleryFlowLayout: UICollectionViewFlowLayout {
    
}
