//
//  ProductsGallery.swift
//  Pharmacy Manager
//
//  Created by Egor Bozko on 24.11.2020.
//  Copyright © 2020 PharmacyManager. All rights reserved.
//

import Foundation
import InputBarAccessoryView

protocol ProductGalleryDelegate: class {
    func didSelect(_ product: ChatProduct)
}

final class ProductsGallery: UIView, InputItem {
    
    private let productsProvider = DataManager<ChatAPI, ProductListResponse>()
    
    enum GaleryState {
        case closed, opened, large
        
        var contentHeight: CGFloat {
            switch self {
            case .closed: return 300.0
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
            
            if appearanceState == .opened {
                willShowGallery()
            }
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
  
    weak var actionsDelegate: ProductGalleryDelegate?
    
    var inputBarAccessoryView: InputBarAccessoryView?
    var parentStackViewPosition: InputStackView.Position?
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: ChatGalleryLayout())
    let searchTextField = UITextView()
    
    let searchTextFieldDecoration = UIView()
    
    var products: [ChatProduct] = []
    var filteredProducts: [ChatProduct] = []
    let clearButton = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 24.0, height: 24.0)))
    let searchPlaceholder = UILabel()
    private let searchDebouncer: Executor = .debounce(interval: 0.5)
    
    private var isSearching: Bool {
        return !searchTextField.text.isEmpty
    }
    
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
        
        searchPlaceholder.text = "Поиск"
        searchPlaceholder.textColor = Asset.LegacyColors.greyText.color
        searchPlaceholder.font = FontFamily.OpenSans.regular.font(size: 16.0)
        searchPlaceholder.translatesAutoresizingMaskIntoConstraints = false
        
        clearButton.setImage(Asset.Images.Chat.clear.image, for: .normal)
        clearButton.addTarget(self, action: #selector(clearSearch), for: .touchUpInside)
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        clearButton.isHidden = true
        
        searchTextField.textColor = Asset.LegacyColors.textDarkBlue.color
        searchTextField.delegate = self
        searchTextField.font = FontFamily.OpenSans.regular.font(size: 16.0)
        searchTextField.isScrollEnabled = false
        searchTextField.textContainerInset = .zero
        collectionView.backgroundColor = .white
        
        searchTextFieldDecoration.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.decelerationRate = .fast
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
        
        addSubview(searchPlaceholder)
        
        NSLayoutConstraint.activate([
            searchPlaceholder.topAnchor.constraint(equalTo: searchTextField.topAnchor, constant: 0.0),
            searchPlaceholder.leftAnchor.constraint(equalTo: searchTextField.leftAnchor, constant: 4.0)
        ])
        
        addSubview(clearButton)
        NSLayoutConstraint.activate([
            clearButton.topAnchor.constraint(equalTo: searchTextField.topAnchor, constant: 1.0),
            clearButton.trailingAnchor.constraint(equalTo: searchTextField.trailingAnchor, constant: 0.0),
            clearButton.heightAnchor.constraint(equalToConstant: 24.0),
            clearButton.widthAnchor.constraint(equalToConstant: 24.0)
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
        
        collectionView.register(ProductGalleryCollectionViewCell.nib, forCellWithReuseIdentifier: ProductGalleryCollectionViewCell.className)
        collectionView.dataSource = self
        collectionView.delegate = self
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: (frame.width / 2) - 1.0, height: 220.0)
            layout.minimumLineSpacing = 1.0
            layout.minimumInteritemSpacing = 1.0
        }
    }
    
    func textViewDidChangeAction(with textView: InputTextView) {}
    func keyboardSwipeGestureAction(with gesture: UISwipeGestureRecognizer) {}
    func keyboardEditingEndsAction() {}
    func keyboardEditingBeginsAction() {
        appearanceState = .closed
        
        UIView.animate(withDuration: 0.3) {
            self.isHidden = true
            self.superview?.layoutIfNeeded()
        }
    }
    
    func willShowGallery() {
        productsProvider.load(target: .lastProducts) {[weak self] result in
            switch result {
            case .success(let response):
                self?.searchTextField.text = ""
                self?.searchPlaceholder.isHidden = false
                self?.products = response.items
                self?.filteredProducts = response.items
                self?.collectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @objc func clearSearch() {
        filteredProducts = products
        clearButton.isHidden = true
        searchTextField.text = ""
        searchPlaceholder.isHidden = false
        searchTextField.resignFirstResponder()
        collectionView.reloadData()
    }
}

extension ProductsGallery: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductGalleryCollectionViewCell.className, for: indexPath)
        (cell as? ProductGalleryCollectionViewCell)?.apply(product: filteredProducts[indexPath.row])
        return cell
    }
}

extension ProductsGallery: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        actionsDelegate?.didSelect(filteredProducts[indexPath.row])
    }
}

extension ProductsGallery: UITextViewDelegate {
       
    func textViewDidBeginEditing(_ textView: UITextView) {
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        clearButton.isHidden = textView.text.isEmpty
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.isEmpty {
            searchPlaceholder.isHidden = false
            clearButton.isHidden = true
        } else {
            searchPlaceholder.isHidden = true
            clearButton.isHidden = false
        }
        searchDebouncer.execute {
            if textView.text.isEmpty {
                self.filteredProducts = self.products
            } else {
                self.filteredProducts = self.products.filter({ $0.name.range(of: textView.text, options: .caseInsensitive, range: nil, locale: nil) != nil })
            }
            
            self.collectionView.reloadData()
        }
    }
}

final class ProductGalleryFlowLayout: UICollectionViewFlowLayout {
    
}


