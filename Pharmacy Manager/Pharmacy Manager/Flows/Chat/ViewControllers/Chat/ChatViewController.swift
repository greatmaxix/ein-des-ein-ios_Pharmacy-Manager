//
//  ChatViewController.swift
//  Pharmacy
//
//  Created by Egor Bozko on 03.11.2020.
//  Copyright © 2020 pharmacy. All rights reserved.
//

import UIKit
import MessageKit
import Photos
import InputBarAccessoryView
import PDFKit

class ChatViewController: MessagesViewController {
   
    var model: ChatInput!
    var chatBar: ChatInputBar? {
        return messageInputBar as? ChatInputBar
    }
    
    lazy var attachmentManager: AttachmentManager = { [unowned self] in
        let manager = AttachmentManager()
        manager.delegate = self
        return manager
    }()
    
    private var photoLibraryAuthorizationStatus: PHAuthorizationStatus!
    private var cameraAuthorizationStatus: AVAuthorizationStatus!
    private let imagePicker = UIImagePickerController()
    private let attachDialogue = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    private var attachedItems: [LibraryImage] = []
    private var isKeyboardVisible: Bool {
            return messageInputBar.inputTextView.isFirstResponder
    }
    var pdfView = PDFView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @objc
    func hideKeyboardIfNeeded() {
        if messageInputBar.inputTextView.isFirstResponder {
            navigationController?.view.endEditing(true)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        model.load()
        title = model.title
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        photoLibraryAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        chatBar?.prepareSubviews()
    }
    
    func setup() {
        messageInputBar = ChatInputBar()
        messageInputBar.delegate = self
        messageInputBar.inputPlugins.append(attachmentManager)
        
        messagesCollectionView.contentInset = UIEdgeInsets(top: 12.0, left: 0.0, bottom: 12.0, right: 0.0)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardIfNeeded))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        messagesCollectionView.backgroundColor = .clear
        showMessageTimestampOnSwipeLeft = false
        view.backgroundColor = .white
        
        imagePicker.delegate = self
        attachDialogue.addAction(UIAlertAction(title: "Галерея", style: .default, handler: { [weak self] _ in
            self?.openGallery()
        }))
        
        attachDialogue.addAction(UIAlertAction(title: "Библиотека", style: .default, handler: { [weak self] _ in
            self?.openLibrary()
        }))
        
        attachDialogue.addAction(UIAlertAction(title: "Камера", style: .default, handler: { [weak self] _ in
            self?.openCamera()
        }))
        
        attachDialogue.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
    }
    
    func showDeniedPhotoMessage() {
        showMessage("Отройте доступ к фото в найстройках приложения")
    }
    
    func showDeniedCameraMessage() {
        showMessage("Отройте доступ к камере в найстройках приложения")
    }
    
    func requestPhotoLibraryAuthorization() {
        PHPhotoLibrary.requestAuthorization {[weak self] status in
            self?.photoLibraryAuthorizationStatus = status
            switch status {
            case .authorized, .limited:
                self?.openGallery()
            case .denied:
                self?.showDeniedPhotoMessage()
            default: break
            }
        }
    }
    
    func requestCameraUsageAuthorization() {
        AVCaptureDevice.requestAccess(for: .video) {[weak self] isGranted in
            self?.cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
            if isGranted {
                self?.openCamera()
            } else {
                self?.showDeniedCameraMessage()
            }
        }
    }
    
    @objc func closeChat() {
        model.closeChat()
    }
}
    
extension ChatViewController: ChatOutput {
    func chatDidChange(_ status: ChatService.ChatStatus) {
        switch status {
        case .closed, .opened, .closeRequest:
            navigationItem.setRightBarButtonItems([], animated: true)
        default:
            navigationItem.setRightBarButtonItems([UIBarButtonItem.init(image: Asset.Images.Chat.close.image, style: .plain, target: self, action: #selector(closeChat))], animated: true)
        }
    }
    
    func openGallery() {
        DispatchQueue.main.async {
            if self.isKeyboardVisible {
                self.navigationController?.view.endEditing(true)
            }
            
            switch self.photoLibraryAuthorizationStatus {
            case .authorized, .limited:
                self.chatBar?.showGallery()
            case .notDetermined, .none:
                self.requestPhotoLibraryAuthorization()
            case .denied, .restricted:
                self.showDeniedPhotoMessage()
            default: break
            }
            self.messagesCollectionView.scrollToBottom(animated: true)
        }
    }
    
    func closeGallery() {
        chatBar?.hideGallery()
    }
    
    func openLibrary() {
        switch photoLibraryAuthorizationStatus {
        case .authorized, .limited:
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        case .notDetermined, .none:
            requestPhotoLibraryAuthorization()
        case .denied, .restricted:
            showDeniedPhotoMessage()
        default: break
        }
    }
    
    func openCamera() {
        switch cameraAuthorizationStatus {
        case .none: break
        case .some(let status):
            switch status {
            case .notDetermined:
                requestCameraUsageAuthorization()
            case .denied, .restricted:
                self.showDeniedCameraMessage()
            case .authorized:
                imagePicker.sourceType = .camera
                imagePicker.allowsEditing = false
                present(imagePicker, animated: true, completion: nil)
            @unknown default: break
            }
        }
    }
    
    func uploadFinished(image: LibraryImage, with result: UploadImageResult) {
        switch result {
        case .success(let response):
            print(response)
        case .failure(let error):
            print(error.localizedDescription)
        }
        
        if let index = attachedItems.firstIndex(of: image) {
            attachmentManager.removeAttachment(at: index)
        }
    }
}

extension ChatViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
        return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        picker.dismiss(animated: true, completion: nil)
        
        guard let pickedImage = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage else { return }
        
        switch picker.sourceType {
        case .camera:
            let image = LibraryImage(originalImage: pickedImage, url: nil, source: .library)
            didSelect(action: .select(image))
        case .photoLibrary, .savedPhotosAlbum:
            guard let url = info[UIImagePickerController.InfoKey.imageURL.rawValue] as? URL else { return }
            let image = LibraryImage(originalImage: pickedImage, url: url, source: .library)
            didSelect(action: .select(image))
        default: break
        }
    }
}

extension ChatViewController: AttachmentManagerDelegate {
    func attachmentManager(_ manager: AttachmentManager, shouldBecomeVisible: Bool) {
        setAttachmentManager(active: shouldBecomeVisible)
    }
    
    func attachmentManager(_ manager: AttachmentManager, didReloadTo attachments: [AttachmentManager.Attachment]) {
        messageInputBar.sendButton.isEnabled = manager.attachments.count > 0
    }
    
    func attachmentManager(_ manager: AttachmentManager, didInsert attachment: AttachmentManager.Attachment, at index: Int) {
        messageInputBar.sendButton.isEnabled = manager.attachments.count > 0
    }
    
    func attachmentManager(_ manager: AttachmentManager, didRemove attachment: AttachmentManager.Attachment, at index: Int) {
        let image = attachedItems[index]
        switch image.source {
        case .gallery(let indexPath):
            attachedItems.remove(at: index)
            chatBar?.chatGallery.deselectItem(at: indexPath, animated: false)
        case .library:
            attachedItems.remove(at: index)
        default: break
        }
        chatBar?.updateAppearanceWithAttachments(count: attachedItems.count)
        messageInputBar.sendButton.isEnabled = manager.attachments.count > 0
    }
    
    func attachmentManager(_ manager: AttachmentManager, didSelectAddAttachmentAt index: Int) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - AttachmentManagerDelegate Helper
    
    func setAttachmentManager(active: Bool) {
        let topStackView = messageInputBar.topStackView
        
        if active && !topStackView.arrangedSubviews.contains(attachmentManager.attachmentView) {
            topStackView.insertArrangedSubview(attachmentManager.attachmentView, at: topStackView.arrangedSubviews.count)
            topStackView.layoutIfNeeded()
        } else if !active && topStackView.arrangedSubviews.contains(attachmentManager.attachmentView) {
            topStackView.removeArrangedSubview(attachmentManager.attachmentView)
            topStackView.layoutIfNeeded()
        }
    }
}

extension ChatViewController: ChatInputBarDelegate {
    func send(_ product: ChatProduct) {
        if isKeyboardVisible {
            navigationController?.view.endEditing(true)
        }
        model.send(product)
    }
    
    func attach() {
        closeGallery()
        present(attachDialogue, animated: true, completion: nil)
    }
    
    func processInputBar(_ inputBar: InputBarAccessoryView) {
        inputBar.inputTextView.text = String()
    }
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        processInputBar(inputBar)
        model.sendMessage(text: text)
        if attachedItems.count > 0 {
            model.upload(images: attachedItems)
            chatBar?.needHideGallery()
        }
    }
    
    func inputBar(_ inputBar: InputBarAccessoryView, textViewTextDidChangeTo text: String) {
        messagesCollectionView.scrollToBottom(animated: false)
    }
    
    func didSelect(action: ImageSelectionAction) {
        switch action {
        case .select(let image):
            guard attachedItems.contains(image) == false else { return }
            attachedItems.append(image)
            attachmentManager.handleInput(of: image.placeholder)
            chatBar?.updateAppearanceWithAttachments(count: attachedItems.count)
        case .deselect(let image):
            if let index = attachedItems.firstIndex(of: image) {
                attachmentManager.removeAttachment(at: index)
            }
        }
    }
}
